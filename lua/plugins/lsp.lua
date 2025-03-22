local M = {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/cmp-path",
        "folke/lsp-colors.nvim",
    },
    cond = function()
      return not vim.g.vscode
    end
}

M.config = function()
  local nvim_lsp = require('lspconfig')
  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>u', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev({ popup_opts = { border = "single" }})<CR>', opts)
    buf_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next({ popup_opts = { border = "single" }})<CR>', opts)
    buf_set_keymap('n', '<leader><tab>', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<leader><leader><tab>', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
  end

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      -- ["<Tab>"] = cmp.mapping.select_next_item({behavior=cmp.SelectBehavior.Insert}),
      ['<Tab>'] = cmp.mapping(function(fallback)
        -- Try Copilot first
        local copilot_keys = ''
        local ok, result = pcall(vim.fn['copilot#Accept'])
        if ok and type(result) == 'string' and result ~= '' then
          copilot_keys = result
        end

        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif copilot_keys ~= '' then
          vim.api.nvim_feedkeys(copilot_keys, 'i', true)
        else
          -- Avoid infinite fallback loop
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n', true)
        end
      end, { 'i', 's' }),
      ['<C-e>'] = cmp.mapping.abort(),
      ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior=cmp.SelectBehavior.Insert}),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
    }, {
      { name = 'buffer' },
    })
  })
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      -- Disable underline, it's very annoying
      underline = false,
      -- Enable virtual text, override spacing to 4
      virtual_text = {spacing = 4},
      signs = true,
      update_in_insert = false
  })

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(
    vim.lsp.handlers.hover,
    {
      border = "single"
    }
  )

  -- vim.lsp.handlers["textDocument/signatureHelp"] =
  --   vim.lsp.with(
  --   vim.lsp.handlers.signature_help,
  --   {
  --     border = "single"
  --   }
  -- )

  local signs = { Error = "▴", Warn = "▴", Hint = "▴", Info = "▴" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl})
  end

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  require'lspconfig'.pyright.setup({
    on_attach=on_attach,
    -- handlers = {
    --   ["textDocument/publishDiagnostics"] = function() end,
    -- },
  })

  -- only use pyright for auto completion, use pylsp for linting
  require'lspconfig'.pylsp.setup{
    settings = {
      pylsp = {
        -- configurationSources = {"flake8", "mypy"},
        -- configurationSources = {"mypy"},
        -- configurationSources = {},
        plugins = {
          flake8 = {
            enabled = true,
            ignore = {"D100", "D101", "D102", "D103", "D104", "D105","D107", "E203", "E501", "W503", "F401", "F841"},
            maxLineLength = 120
          },
          mypy = {enabled=true},
          pylint = {enabled=false},
          pydocstyle = {enabled=false},
          pycodestyle = {enabled=false},
          pyflakes = {enabled=false},
          jedi_completion = {enabled=true},
        },
      },
      -- disable pylsp for now
    },
    on_attach=on_attach
  }


  -- require("lspconfig").pyright.setup{
  --     settings = {
  --       python = {
  --         analysis = {
  --           autoSearchPaths = true,
  --           diagnosticMode = "workspace",
  --           reportPrivateImportUsage = false,
  --         },
  --       },
  --     },
  --     -- single_file_support = true
  -- }

  -- require "lsp_signature".setup({
  --   bind = true, -- This is mandatory, otherwise border config won't get registered.
  --   handler_opts = {
  --     border = "single"
  --   },
  --   hint_enable = false,
  -- })

  -- copilot settings
  vim.g.copilot_no_tab_map = true
  vim.g.copilot_assume_mapped = true
  vim.g.copilot_tab_fallback = ""
end

return M
