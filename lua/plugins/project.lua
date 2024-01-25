return {

    "ahmedkhalf/project.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
        { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
    },
    config = function()
        require("project_nvim").setup {
            detection_methods = { "pattern" },
            patterns = {
                ".git",
                "_darcs",
                "Makefile",
                "package.json",
                "pyproject.toml",
                ">workspace",
            },
            show_hidden = true,
            silent_chdir = false,
            datapath = vim.fn.stdpath "data",
        }
        require("telescope").load_extension "projects"
    end,
}
