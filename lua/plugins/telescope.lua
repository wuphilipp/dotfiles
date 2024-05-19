----------------------------------------------[[  Example Spec  ]]
-- This file shows how to organize a more involved plugin
-- Plugins requiring fewer options can be put into lua/plugins/init.lua

local M = {
    -- See https://github.com/folke/lazy.nvim#-plugin-spec
    "nvim-telescope/telescope.nvim", branch = "0.1.x", -- optional branch lock
    dependencies = {
        { "nvim-lua/plenary.nvim" } -- these can also have their own plugin file
    },
    cmd = { "Telescope" }, -- lazy loads on these commands
}

function M.config()
    local telescope = require("telescope")
    local actions = require('telescope.actions')
    telescope.setup({
        defaults= {
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous",
                    ["<C-c>"] = actions.close,
                },
            },
        }
    })
    function vim.getVisualSelection()
        vim.cmd('noau normal! "vy"')
        local text = vim.fn.getreg('v')
        vim.fn.setreg('v', {})
        text = string.gsub(text, "\n", "")
        if #text > 0 then
            return text
        else
            return ''
        end
    end

    local tb = require('telescope.builtin')
    local opts = { noremap = true, silent = true }
end


-- Lazy loads on these mappings
M.keys = {
    ---MAPPING------COMMAND---------------------------MODE-----DESCRIPTION-----------------
    -- { "<leader>ff", "<cmd>:Telescope find_files<CR>", { "n" }, desc = "Telescope files"   },
    { "<C-p>", "<cmd>:Telescope find_files<CR>", { "n" }, desc = "Telescope files"   },
    { "<leader>p",  "<cmd>:Telescope buffers<CR>", { "n" }, desc = "Telescope buffers" },
    { "<leader>h", "<cmd>:Telescope oldfiles<CR>", { "n" }, desc = "Telescope history" },
    { "<leader>t",  "<cmd>:Telescope tags<CR>", { "n" }, desc = "Telescope tags" },
    { "<leader>l",  "<cmd>:Telescope current_buffer_fuzzy_find<CR>", { "n" }, desc = "Telescope lines"   },

    -- { "<leader>a",  "<cmd>:Telescope grep_string<CR>", { "v" }, desc = "Telescope selection"},
    -- { "<leader>a",  "<cmd>:Ag<CR>", { "n"}, desc = "Telescope grep"},
    -- { "<leader>ga", "<cmd>:execute 'Ag ' . expand('<cword>')<CR>", { "n"}, desc = "Telescope grep"},
    { "<leader>ga", "<cmd>:Telescope grep_string<CR>", { "n"}, desc = "Telescope grep"},
    { "<leader>g",  "<cmd>:Telescope live_grep<CR>", { "n"}, desc = "Telescope grep"},
    { "<leader>ss",  "<cmd>:Telescope spell_suggest<CR>", { "n" }, desc = "Telescope spell suggest" },
}
return M
