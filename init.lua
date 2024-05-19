-- .
-- ├── init.lua
-- ├── ...
-- └── lua
--     ├── plugins
--     │   ├── init.lua             -- Loads simple plugins
--     │   └── telescope.lua		-- Larger plugins have separate files
--     └── user
--         ├── lazy_bootstrap.lua
--         ├── maps.lua
--         └── options.lua

-- NOTE: ensure that you map <leader> before loading Lazy

require("user/lazy_bootstrap")   -- bootstraps folke/lazy
require("user/options")          -- loads options, colors, etc.
require("user/maps")             -- loads non-plugin maps
require("lazy").setup("plugins") -- loads each lua/plugin/*

-- colors
-- vim.cmd("set t_Co=256")
vim.opt.termguicolors = true
vim.cmd([[color xoria256]])

vim.cmd("set background=dark")
vim.cmd("highlight MatchParen cterm=bold,underline ctermbg=none ctermfg=7 guifg=#c0c0c0 gui=bold,underline guibg=none")
-- vim.cmd("highlight VertSplit ctermfg=0 ctermbg=0 guifg=#000000 guibg=#000000")
vim.cmd("highlight CursorLineNr cterm=bold ctermfg=232 ctermbg=250 gui=bold")
vim.cmd("highlight Visual cterm=bold ctermbg=238 gui=bold guibg=#444444")
vim.cmd("highlight TrailingWhitespace ctermbg=52 guibg=#5f0000")
vim.cmd("let g:indentLine_color_term=237")
vim.cmd("highlight IndentLine ctermbg=none ctermfg=237 guibg=none guifg=#3a3a3a")
vim.cmd("highlight SpecialKey ctermfg=238 guifg=#444444 ctermbg=234 guibg=#1c1c1c")
vim.cmd("highlight Pmenu ctermfg=252 ctermbg=236 guifg=#d0d0d0 guibg=#303030")
vim.cmd("highlight PmenuSel cterm=bold ctermfg=255 ctermbg=238 gui=bold guifg=#eeeeee guibg=#444444")
vim.cmd("highlight PmenuSbar ctermbg=236 guibg=#303030")
vim.cmd("highlight FloatBorder ctermfg=242 ctermbg=236 guifg=#6c6c6c guibg=#303030")
vim.cmd("highlight link NormalFloat Pmenu")
vim.cmd("highlight clear Todo")
-- vim.cmd("let l:todo_color = 247")
-- vim.cmd("execute 'highlight Todo ' . l:comment_highlight . ' cterm=bold ctermfg=' . l:todo_color")

vim.cmd("highlight String ctermfg=144 guifg=#afaf87")
vim.cmd("highlight Identifier ctermfg=183 guifg=#d7afff cterm=none")
vim.cmd("highlight Type ctermfg=98 guifg=#875fd7 cterm=none gui=none")
vim.cmd("highlight LineNr ctermfg=241 ctermbg=234 guifg=#5f5f5f guibg=#1c1c1c")
vim.cmd("highlight SignColumn ctermfg=241 ctermbg=234 guifg=#5f5f5f guibg=#1c1c1c")
-- vim.cmd("highlight NonText ctermfg=238 guifg=#5f0000 ctermbg=234 guibg=#1c1c1c")
-- vim.cmd("highlight Normal ctermfg=252 ctermbg=234 guifg=#5f0000 guibg=#1c1c1c")
vim.cmd("highlight Constant ctermfg=229  guifg=#ffffaf cterm=bold")
vim.cmd("highlight Boolean ctermfg=229  guifg=#ffffaf")
vim.cmd("highlight PythonFunctionCall ctermfg=183  guifg=#d7afff")
vim.cmd("highlight PythonFunction ctermfg=183  guifg=#d7afff")


vim.cmd("highlight SpellBad cterm=bold,italic ctermfg=red gui=bold,italic guifg=red")

-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })
--
-- vim.api.nvim_create_autocmd("BufRead,BufNewFile", {
--     pattern = "ja*.py",
--     command = "set filetype=python",
-- })


if vim.g.vscode then
    vim.api.nvim_set_keymap('n', '<leader>gd', '<Cmd>lua require("vscode-neovim").action("git.openChange")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>gb', '<Cmd>lua require("vscode-neovim").action("vscode-github.browseCurrentFile")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>ttws', '<Cmd>lua require("vscode-neovim").action("trailing-spaces.deleteTrailingSpaces")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>pi', '<Cmd>lua require("vscode-neovim").action("editor.action.quickFix")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua require("vscode-neovim").action("editor.action.showHover")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>t', '<Cmd>lua require("vscode-neovim").action("workbench.action.showAllSymbols")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>w', '<Cmd>lua require("vscode-neovim").action("workbench.action.files.save")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>W', '<Cmd>lua require("vscode-neovim").action("workbench.action.files.save")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>d', '<Cmd>lua require("vscode-neovim").action("editor.action.revealDefinition")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>r', '<Cmd>lua require("vscode-neovim").action("editor.action.rename")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>u', '<Cmd>lua require("vscode-neovim").action("editor.action.goToReferences")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>pp', 'oimport ipdb; ipdb.set_trace();<esc>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>cf', '<Cmd>lua require("vscode-neovim").action("editor.action.formatDocument")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader><tab>', '<Cmd>lua require("vscode-neovim").action("editor.action.marker.next")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>a', '<Cmd>lua require("vscode-neovim").action("workbench.action.findInFiles")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>h', '<Cmd>lua require("vscode-neovim").action("workbench.action.showAllEditorsByMostRecentlyUsed")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>ci', '<Cmd>lua require("vscode-neovim").action("editor.action.commentLine")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>cc', '<Cmd>lua require("vscode-neovim").action("editor.action.addCommentLine")<CR>', { noremap = true, silent = true })

    vim.api.nvim_set_keymap('n', '<leader>n', '<Cmd>lua require("vscode-neovim").action("workbench.action.nextEditor")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>N', '<Cmd>lua require("vscode-neovim").action("workbench.action.previousEditor")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>tt', '<Cmd>lua require("vscode-neovim").action("workbench.action.files.newUntitledFile")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>q', '<Cmd>lua require("vscode-neovim").action("workbench.action.closeActiveEditor")<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>wq', [['<Cmd>lua require("vscode-neovim").action("workbench.action.files.save")<CR>'],['<Cmd>lua require("vscode-neovim").action("workbench.action.closeActiveEditor")<CR>']], { noremap = true, silent = true })

    -- Keymap for searching the visual selection in the current file using VSCode
    vim.api.nvim_set_keymap('n', '<leader>a', '<Cmd>lua require("vscode-neovim").action("workbench.action.findInFiles", { args = { query = vim.fn.expand("<cword>") } })<CR>', { noremap = true, silent = true })
    vim.cmd([[
        command! FindInFileS call VSCodeNotify('workbench.action.findInFiles', {'query': @p})
        xnoremap <silent> <Leader>a "py<Esc>:FindInFileS<CR>
    ]])
end
