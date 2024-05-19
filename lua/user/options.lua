local fn = vim.fn
local o = vim.opt

-- " #############################################
-- " > General Settings <
-- " #############################################
-- set nocompatible " Disable vi compatability
-- set shell=/bin/bash " Run shell commands using bash
-- set number
-- set relativenumber
-- set scrolloff=1000
-- set wildmenu wildmode=longest:full,full
-- set laststatus=2 " Show the statusline, always!
-- set noshowmode " Hide redundant mode indicator underneath statusline
-- set hlsearch " Highlight searches
-- set incsearch " Search as characters are entered
-- set timeoutlen=300 ttimeoutlen=10 " Make escape insert mode zippier
-- set backspace=2 " Allow backspacing over everything (eg line breaks)
-- set history=50 " Expand history of saved commands
-- set foldmethod=indent foldlevel=99 " Fold behavior tweaks
--
-- " Set plugin, indentation settings automatically based on the filetype
-- filetype plugin indent on

o.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- A comma separated list of options for Insert mode completion
o.number = true -- show line numbers (or only the current one)
o.relativenumber = true -- line numbers
o.shiftwidth = 4
if not vim.g.vscode then
    o.scrolloff = 1000 -- minimum number of screen lines to keep above and below the cursor
end
o.showmode = false -- don't show mode
o.smartcase = true -- smart case
o.smartindent = true -- make indenting smarter again
o.swapfile = false -- enable/disable swap file creation
o.tabstop = 4 -- how many columns a tab counts for
o.expandtab = true -- use spaces instead of tabs
o.termguicolors = true -- set term gui colors (most terminals support this)
o.undodir = fn.stdpath("data") .. "/undodir" -- set undo directory
o.undofile = true -- enable/disable undo file creation
o.wildignorecase = true -- When set case is ignored when completing file names and directories
o.wildmode = "longest:full,full" -- A comma separated list of options for file name completion
o.hlsearch = true -- highlight search results
o.incsearch = true -- show search results as you type
o.history = 100 -- how many lines of history to keep
vim.cmd [[
  filetype plugin indent on
]]


-- crosshairs
vim.cmd([[
augroup InsertModeCrossHairs
    autocmd!
    autocmd InsertEnter * set cursorline
    autocmd InsertLeave * set nocursorline
    autocmd InsertEnter * set cursorcolumn
    autocmd InsertLeave * set nocursorcolumn
augroup END
]])

vim.cmd [[
  au BufRead,BufNewFile *.xml set filetype=xml
]]

-- set list listchars=tab:>·,trail:\ ,extends:»,precedes:«,nbsp:×vimrc
o.list = true
o.listchars = { tab = "» ", trail = "·", extends = "»", precedes = "«", nbsp = "×" }

vim.cmd [[
  set diffopt+=vertical
]]
o.splitright = true
o.splitbelow = true
