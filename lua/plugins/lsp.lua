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
        "folke/lsp-colors.nvim",
    },
    cond = function()
      return not vim.g.vscode
    end
}

M.config = function()
  -- LSP keymaps (applied via LspAttach autocmd)
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      local opts = { buffer = ev.buf, noremap = true, silent = true }
      vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>u', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[g', function() vim.diagnostic.goto_prev({ float = { border = "single" }}) end, opts)
      vim.keymap.set('n', ']g', function() vim.diagnostic.goto_next({ float = { border = "single" }}) end, opts)
      vim.keymap.set('n', '<leader><tab>', vim.diagnostic.setloclist, opts)
      vim.keymap.set('n', '<leader><leader><tab>', vim.diagnostic.setqflist, opts)

      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    end,
  })

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

  -- Diagnostic config (nvim 0.11+ style)
  vim.diagnostic.config({
    underline = false,
    virtual_text = { spacing = 4 },
    signs = true,
    update_in_insert = false,
    float = { border = "single" },
  })

  -- Hover handler border
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = "single" }
  )

  -- Diagnostic signs
  local signs = { Error = "▴", Warn = "▴", Hint = "▴", Info = "▴" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
  end

  -- LSP capabilities for nvim-cmp
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Configure LSP servers using vim.lsp.config (nvim 0.11+)
  vim.lsp.config('pyright', {
    capabilities = capabilities,
  })

  vim.lsp.config('pylsp', {
    capabilities = capabilities,
    settings = {
      pylsp = {
        plugins = {
          flake8 = {
            enabled = true,
            ignore = {"D100", "D101", "D102", "D103", "D104", "D105","D107", "E203", "E501", "W503", "F401", "F841"},
            maxLineLength = 120
          },
          mypy = { enabled = true },
          pylint = { enabled = false },
          pydocstyle = { enabled = false },
          pycodestyle = { enabled = false },
          pyflakes = { enabled = false },
          jedi_completion = { enabled = true },
        },
      },
    },
  })

  -- Enable the configured servers
  vim.lsp.enable('pyright')
  vim.lsp.enable('pylsp')

  -- copilot settings
  vim.g.copilot_no_tab_map = true
  vim.g.copilot_assume_mapped = true
  vim.g.copilot_tab_fallback = ""
end

return M
