---------------------------------------------[[ Non-plugin maps ]]
-- Plugin maps go into `plugins/*` files 
-- (see lua/plugins/telescope.lua as an example)

local opts = { silent = true , noremap = true}
local expr_opts = { silent = true, expr = true }

vim.g.mapleader = " "

vim.keymap.set({ "n"      }, "x"        , '"_x') -- use the blackhole register for deletions
-- vim.keymap.set({ "n"      }, "<ESC>"    , ":noh<CR>", opts) -- turn off search highlight!
-- vim.keymap.set({ "n", "v" }, "<leader>p", '"0p',      opts, { desc = "Paste from yank register" })

vim.keymap.set({ "n"      }, "<Leader>;;", ":noh<CR>", opts)
vim.keymap.set({ "n"      }, "<Leader>[[", ":noh<CR>", opts)
vim.keymap.set({ "n"      }, "<Leader>]]", ":noh<CR>", opts)
vim.keymap.set({ "n"      }, "<Leader>jk", ":noh<CR>", opts)
vim.keymap.set({ "i"      }, "jk"        , "<ESC>",    opts)

vim.keymap.set({ "v"      }, "<Leader>jk", "<ESC>",    opts)
vim.keymap.set({ "v"      }, "<"         , "<gv",      opts)
vim.keymap.set({ "v"      }, ">"         , ">gv",      opts)

-- us gj gk by default, unless trying to jump more than 5 lines
vim.keymap.set({ "n" }, "j", function()
    return vim.v.count > 0 and vim.v.count > 5 and "m'" .. vim.v.count .. "j" or "gj"
end, expr_opts)
vim.keymap.set({ "n" }, "k", function()
    return vim.v.count > 0 and vim.v.count > 5 and "m'" .. vim.v.count .. "k" or "gk"
end, expr_opts)

vim.keymap.set({ "n" }, "<ESC>", ":noh<CR>:redraw!<CR><ESC>", opts)
vim.keymap.set({ "n" }, "<Leader>tln", function()
    vim.opt.number = not vim.opt.number
    vim.opt.relativenumber = not vim.opt.relativenumber
end, opts)

vim.keymap.set({ "n" }, "<Leader>wq", ":wq<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>w" , ":w<CR>",  opts)
vim.keymap.set({ "n" }, "<Leader>q" , ":q<CR>",  opts)
vim.keymap.set({ "n" }, "<Leader>ip", ":set invpaste<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>ttws", ":%s/\\s\\+$//e<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>rtw", ":%s/\\<<C-r><C-w>\\>/", opts)
vim.keymap.set({ "v" }, "<Leader>rtw", "y:%s/\\V\\C<C-R>=escape(@\", '/\\')<CR>//g<Left><Left>", opts)

vim.keymap.set({ "n", "v"}, "<C-u>", "20k", opts)
vim.keymap.set({ "n", "v"}, "<C-d>", "20j", opts)

--vim.keymap.set({ "n" }, "<Leader>rtwe", ":cdo s/\<<C-r><C-w>\>//g \| update <left><left><left><left><left><left><left><left><left><left><left><left>", opts)
--vim.keymap.set({ "v" }, "<Leader>rtwe", "y:cdo s/\\V\\C<C-R>=escape(@\", '/\\')<CR>//g \\| update <left><left><left><left><left><left><left><left><left><left><left><left>", opts)


vim.keymap.set({ "n" }, "<Leader>tt", ":tabnew<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>n" , ":tabn<CR>",  opts)
vim.keymap.set({ "n" }, "<Leader>tn", "<C-w>T",      opts)

if not vim.g.vscode then
    vim.keymap.set({ "n" }, "<Up>"  , ":exe 'resize +5'<CR>", opts)
    vim.keymap.set({ "n" }, "<Down>", ":exe 'resize -5'<CR>", opts)
    vim.keymap.set({ "n" }, "<Right>", ":exe 'vert resize +5'<CR>", opts)
    vim.keymap.set({ "n" }, "<Left>", ":exe 'vert resize -5'<CR>", opts)

    vim.keymap.set({ "n" }, "<Leader>pp", "Oimport ipdb; ipdb.set_trace();<ESC>", opts)
    vim.keymap.set({ "n" }, "<Leader>ps", "O@settings(print_blob=True)<ESC>", opts)
end

local function adaptive_motion(next_flag)
    -- Check if diff is open
    if vim.opt.diff:get() then
        if next_flag then
            vim.cmd('normal ]c')
        else
            vim.cmd('normal [c')
        end
        return
    end

    -- Check for windows
    local windows = vim.fn.getwininfo()

    -- Check for any loclist windows
    local loclist_windows_exists = false
    for _, win in ipairs(windows) do
        if vim.fn.getloclist(win.winid, {filewinid = 0}).filewinid > 0 then
            loclist_windows_exists = true
            break
        end
    end

    if loclist_windows_exists then
        if next_flag then
            if not pcall(vim.cmd, 'lnext') then vim.cmd('lfirst') end
        else
            if not pcall(vim.cmd, 'lprev') then vim.cmd('llast') end
        end
        return
    end

    local quickfix_windows = vim.tbl_filter(function(win)
        return win.quickfix == 1
    end, windows)

    if #quickfix_windows > 0 then
        if next_flag then
            if not pcall(vim.cmd, 'cnext') then vim.cmd('cfirst') end
        else
            if not pcall(vim.cmd, 'cprev') then vim.cmd('clast') end
        end
        return
    end


    -- Tab through LSP diagnostics without loclist
    local diagnostics = vim.diagnostic.get(0)
    if #diagnostics > 0 then
        local success
        if next_flag then
            success = pcall(vim.diagnostic.goto_next, { popup_opts = { border = 'single' }})
            if not success then vim.diagnostic.goto_prev({wrap = false}) end -- go to the first
        else
            success = pcall(vim.diagnostic.goto_prev, { popup_opts = { border = 'single' }})
            if not success then vim.diagnostic.goto_next({wrap = false}) end -- go to the last
        end
        return
    end

    print('Adaptive motion: no target found')
end


vim.keymap.set('n', '<Tab>', function() adaptive_motion(true) end, {silent = true, noremap = true})
vim.keymap.set('n', '<S-Tab>', function() adaptive_motion(false) end, {silent = true, noremap = true})

vim.keymap.set({ "n" }, "<Leader>gm", ":Git mergetool<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>gb", ":GBrowse<CR>", opts)
vim.keymap.set({ "v" }, "<Leader>gb", ":GBrowse<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>gs", ":Gstatus<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>gd", ":Gdiff<CR>", opts)
vim.keymap.set({ "n" }, "<Leader>sc", ":setlocal spell! spelllang=en_us<CR>", opts)

-- vnoremap  <leader>y  "+y
-- nnoremap  <leader>y  "+y
vim.keymap.set({ "v" }, "<Leader>y", '"+y', opts)
vim.keymap.set({ "n" }, "<Leader>y", '"+y', opts)

vim.keymap.set({ "v" }, "<Leader>c", '"+y', opts)
vim.keymap.set({ "n" }, "<Leader>c", '"+y', opts)
vim.keymap.set({ "v" }, "<Leader>v", '"+p', opts)
vim.keymap.set({ "n" }, "<Leader>v", '"+p', opts)

if not vim.g.vscode then
    vim.keymap.set({ "n" }, "<Leader>pi", ":ImportName<CR><C-o>", opts)
    vim.keymap.set({ "n" }, "<Leader>pih", ":ImportNameHere<CR>", opts)
end

vim.keymap.set({ "n" }, "<Leader>cf", ":FormatCode<CR>:redraw!<CR>", opts)
vim.keymap.set({ "v" }, "<Leader>cf", ":FormatLines<CR>:redraw!<CR>", opts)
vim.cmd([[
augroup CodeFmtSettings
    autocmd!

    " Autoformatter configuration
    " Async Python formatting: run isort, then Black
    " + some hacky stuff to prevent cursor jumps
    "
    " If formatting in visual mode, use yapf
    autocmd FileType python nnoremap <buffer> <Leader>cf :call FormatPython()<CR>
    autocmd FileType python vnoremap <buffer> <Leader>cf :FormatLines yapf<CR>:redraw!<CR>

augroup END

function! FormatPython()
    let g:format_python_restore_pos = getpos('.')
    let g:format_python_orig_line_count = line('$')
    call isort#Isort(1, line('$'), function('FormatPythonCallback'))
endfunction

function! FormatPythonCallback()
    if g:format_python_orig_line_count != line('$')
        call codefmt#FormatBuffer('black') | execute 'redraw!'
        call setpos('.', g:format_python_restore_pos)
    else
        call codefmt#FormatBuffer('black') | execute 'redraw!'
    endif
endfunction

" Use prettier for HTML, CSS, Javascript, Markdown, Liquid
autocmd FileType html,css,javascript,markdown,liquid let b:codefmt_formatter='prettier'
]])

-- vim.cmd([[
-- function! s:GrepVisual(type)
--     " Save the contents of the unnamed register
--     let l:save_tmp = @@
--
--     " Copy visual selection into unnamed_register
--     if a:type ==# 'v'
--         normal! `<v`>y
--     elseif a:type ==# 'char'
--         normal! `[v`]y
--     else
--         return
--     endif
--
--     execute 'Telescope grep_string search=' @@
--
--     " Restore the unnamed register
--     let @@ = l:save_tmp
-- endfunction
-- vnoremap <Leader>a :<C-U>call <SID>GrepVisual(visualmode())<CR>
-- ]])

vim.cmd([[
    nnoremap <leader>a :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })<CR>
]])

-- vim.cmd([[
--     vnoremap <Leader>a :lua require("telescope.builtin").grep_string({search=vim.fn.input("Grep for > ")})<CR>
-- ]])
function _G.get_visual_selection()
    local save_reg = vim.fn.getreg('v')
    local save_regtype = vim.fn.getregtype('v')
    vim.cmd('normal! gv"vy')
    local selection = vim.fn.getreg('v')
    vim.fn.setreg('v', save_reg, save_regtype)
    selection = selection:gsub("\n", "")
    return selection
end
vim.api.nvim_set_keymap('x', '<leader>a', [[:lua require('telescope.builtin').grep_string({ search = _G.get_visual_selection() })<CR>]], {noremap = true, silent = true})


function _G.telescope_grep_from_input(input)
    require('telescope.builtin').grep_string({ search = input })
end
vim.api.nvim_create_user_command(
    'Ag',
    function(opts)
        _G.telescope_grep_from_input(opts.args)
    end,
    {nargs = 1} -- This specifies that the command expects one argument
)


vim.cmd([[
let initial_prompt =<< trim END
>>> system
Role: Act as a completion engine providing high-quality, concise code and text completions, generations, transformations, or explanations.

Specifications:
- Task: Generate code with type annotations and documentation, or provide clear text transformations and explanations.
- Topic: General programming and text editing.
- Style: Deliver results directly without elaborate commentary unless requested.
- Audience: Users of text editors and programmers seeking text and code transformation/generation functionality.

Detailed Behavior:
1. Code Generation:
   - Include type annotations for all functions and variables.
   - Provide clear documentation for each function or class.
   - Ensure code is clean, well-structured, and follows best practices.
2. Text Completion and Transformation:
   - Complete sentences, paragraphs, or text blocks accurately based on context.
   - Transform text as requested, improving clarity and readability.
   - Provide explanations for transformations when necessary.
3. Explanations:
   - Offer clear explanations for code snippets, algorithms, or text transformations.
   - Break down logic step-by-step and describe key components.

Interaction Guidelines:
- Respond promptly and accurately to user inputs.
- Focus on delivering the requested completion or transformation without unnecessary commentary.
- Provide thorough and clear responses when additional details are requested.
END







let chat_engine_config = {
\  "engine": "chat",
\  "options": {
\    "model": "gpt-4o",
\    "max_tokens": 1000,
\    "temperature": 0.1,
\    "request_timeout": 20,
\    "initial_prompt": initial_prompt,
\    "endpoint_url": "https://api.openai.com/v1/chat/completions",
\  },
\ }

let g:vim_ai_complete = chat_engine_config
let g:vim_ai_edit = chat_engine_config

xnoremap <Leader>ai :AIChat<CR>
nnoremap <Leader>ai :AIChat<CR>
nnoremap <Leader><Leader>ai :below new /tmp/last_conversation.aichat
vnoremap <Leader>ai :AIEdit
]])
