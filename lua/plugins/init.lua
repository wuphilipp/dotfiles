return {
  { "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup()
    end
  },
  -- {'altermo/nwm',branch='x11'},
  -- {'madox2/vim-ai'},
  {"vim-scripts/restore_view.vim",
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      vim.g.viewoptions = "cursor,folds,slash,unix"
    end
  },
  { "tpope/vim-surround" },
  -- { "altermo/nxwm", branch="x11" }, # run stuff in browse
  { "tpope/vim-repeat" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-fugitive" },
  { "mhinz/vim-signify",
    config=function()
      vim.cmd [[
      set updatetime=300
      augroup SignifyColors
          autocmd!
          function! s:SetSignifyColors()
              highlight SignColumn ctermbg=NONE guibg=NONE
              highlight SignifySignAdd ctermfg=green guifg=#00ff00 cterm=NONE gui=NONE
              highlight SignifySignDelete ctermfg=red guifg=red cterm=NONE gui=NONE
              highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE
          endfunction
          autocmd ColorScheme * call s:SetSignifyColors()
      augroup END
      let g:signify_sign_add = '•'
      let g:signify_sign_delete = '•'
      let g:signify_sign_delete_first_line = '•'
      let g:signify_sign_change = '•'
      let g:signify_priority = 5
      ]]
    end
  },
  { "wuphilipp/python-imports.vim",
    cond=function() return not vim.g.vscode end
  },
  { "xiyaowong/nvim-cursorword",
    cond=function() return not vim.g.vscode end,
    config = function()
      vim.g.cursorword_min_width = 3
    end
  },
  { "bronson/vim-visual-star-search", cond=function() return not vim.g.vscode end  },
  -- { "github/copilot.vim" , cond=function() return not vim.g.vscode end },
  { "vim-scripts/xoria256.vim" },
  -- { "easymotion/vim-easymotion" },
  { "norcalli/nvim-colorizer.lua", cond=function() return not vim.g.vscode end },
  { "windwp/nvim-autopairs", config = true }, -- See `config` under https://github.com/folke/lazy.nvim#-plugin-spec
  { "numToStr/Comment.nvim", config = true },
  { "google/vim-codefmt", dependencies = { "google/vim-maktaba", "brentyi/isort.vim" } },
  { "brentyi/isort.vim",
    cond = function() return not vim.g.vscode end,
    config = function()
      vim.g.isort_vim_options = "--profile black"
      vim.cmd([[
      augroup IsortMappings
          autocmd!
          autocmd FileType python nnoremap <buffer> <Leader>si :Isort<CR>
          autocmd FileType python vnoremap <buffer> <Leader>si :Isort<CR>
      augroup END
      ]])
    end
  },
  { "scrooloose/nerdcommenter", 
    config = function()
	  vim.g.NERDSpaceDelims = 1
	  vim.g.NERDCompactSexyComs = 1
	  vim.g.NERDCommentEmptyLines = 1
	  vim.g.NERDTrimTrailingWhitespace = 1
	  vim.g.NERDDefaultAlign = 'left'
	  vim.g.NERDAltDelims_python = 1
	  vim.g.NERDAltDelims_cython = 1
	  vim.g.NERDAltDelims_pyrex = 1
	end  },
  { "scrooloose/nerdtree",
    config = function()
	  vim.g.NERDTreeShowHidden = 1
	  vim.g.NERDTreeShowLineNumbers = 1
	  vim.g.NERDTreeMinimalUI = 1
	  vim.g.NERDTreeFileExtensionHighlightFullName = 1
	  vim.g.NERDTreeExactMatchHighlightFullName = 1
	  vim.g.NERDTreePatternMatchHighlightFullName = 1
	  vim.g.NERDTreeMapJumpNextSibling = '<Nop>'
	  vim.g.NERDTreeMapJumpPrevSibling = '<Nop>'
	  vim.api.nvim_set_keymap('n', '<Leader>o', ':NERDTree %<CR>', { noremap = true, silent = true })
	  vim.api.nvim_set_keymap('n', '<Leader>ot', ':NERDTreeToggle %<CR>', { noremap = true, silent = true })
	end
  },
  { "airblade/vim-rooter",
    config = function()
	  vim.g.rooter_silent_chdir = 1
	  vim.g.rooter_change_directory_for_non_project_files = "current"
	end,
    cond=function() return not vim.g.vscode end 
  },
  { "sheerun/vim-polyglot",
    config = function()
        -- vim.g.polyglot_disabled = { 'csv' }
        vim.g.vim_markdown_conceal = 0
        vim.g.vim_markdown_conceal_code_blocks = 0
        vim.g.vim_markdown_auto_insert_bullets = 0
        vim.g.vim_markdown_new_list_item_indent = 0
        vim.g.vim_markdown_math = 1
    end,
  },
  { "christoomey/vim-tmux-navigator",
    config = function()
		vim.g.tmux_navigator_disable_when_zoomed= 1
	end,
    cond = function()
      return not vim.g.vscode
    end
  },
  { "wookayin/semshi",
      cond = function()
        return not vim.g.vscode
      end,
      ft = "python",
      build = ":UpdateRemotePlugins",
      init = function()
          vim.g["semshi#error_sign"] = false
          vim.g["semshi#simplify_markup"] = false
          vim.g["semshi#mark_selected_nodes"] = false
          vim.g["semshi#update_delay_factor"] = 0.001

          -- This autocmd must be defined in init to take effect
          vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
            group = vim.api.nvim_create_augroup("SemanticHighlight", {}),
            callback = function()
                -- Only add style, inherit or link to the LSP's colors
                vim.cmd([[
                    highlight semshiGlobal         ctermfg=183 guifg=#d7afff
                    highlight semshiImported    ctermfg=146 guifg=#afafdf cterm=none gui=none
                    highlight semshiParameter       ctermfg=252  guifg=#d0d0d0 cterm=bold gui=bold
                    highlight semshiFree    ctermfg=201 guifg=#ff00ff " TODO what even is this?
                    highlight semshiBuiltin    ctermfg=98 guifg=#875fff
                    highlight semshiAttribute       ctermfg=252  guifg=#d0d0d0
                    highlight semshiSelf        ctermfg=214 guifg=#ffaf00
                ]])
            end,
          })
      end,
  },
}
