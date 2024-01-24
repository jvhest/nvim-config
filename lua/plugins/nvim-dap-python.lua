return {
    "mfussenegger/nvim-dap-python",
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    ft = "python", -- filetype
    config = function()
        require("dap-python").setup "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    end,
}
