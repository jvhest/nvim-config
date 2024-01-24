return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>ng", "<CMD>Neorg workspace general<CR>", desc = "Neorg general" },
        { "<leader>np", "<CMD>Neorg workspace projects<CR>", desc = "Neorg projects" },
    },
    lazy = false,
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            general = "~/Documents/Notes/general",
                            projects = "~/Documents/Notes/projects",
                        },
                        default_workspace = "general",
                    },
                },
            },
        }
    end,
}
