return {

  "ahmedkhalf/project.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
  },
  opts = {
    patterns = {
    ".git",
    "_darcs",
    "Makefile",
    "package.json",
    "pyproject.toml",
    ">workspace" },
  },
  config = function(_, opts)
    require("project_nvim").setup(opts)
    require('telescope').load_extension('projects')
  end,
}
