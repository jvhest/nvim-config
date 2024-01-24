return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      signs = {
        add = { hl = "GitSignAdd",    text = "+" },
        change = { hl = "GitSignChange", text = "~" },
        delete = { hl = "GitSignDelete", text = "_" },
        topdelete = { hl = "GitSignDelete", text = "‾" },
        changedelete = { hl = "GitSignChange", text = "|" },
      },

      on_attach = function(bufnr)
        local function map(mode, l, r, opts)
           opts = opts or {}
           opts.buffer = bufnr
           vim.keymap.set(mode, l, r, opts)
        end
        -- local gs = package.loaded.gitsigns
        local gs = require('gitsigns')

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return "<Ignore>"
        end, { expr = true, desc = "next hunk" })

        map("n", "[c", function()
           if vim.wo.diff then
             return "[c"
           end
           vim.schedule(function()
             gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "previous hunk" })

        -- Actions
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", function()
            gs.blame_line { full = true, desc = "Blame line" }
        end)

        -- map("n", "<leader>hn", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true, desc = "Next git hunk" })
        -- map("n", "<leader>hp", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true, desc = "Previous git hunk" })
        -- map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
        -- map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo staging hunk" })
        -- map({ "n", "v" }, "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
        -- map("n", "<leader>hb", gs.blame_line, { desc = "Blame line" })
        -- map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
        -- map("n", "<leader>hP", gs.preview_hunk, { desc = "Preview hunk" })
      end,
      current_line_blame = false,
      sign_priority = 5,
      update_debounce = 500,
      status_formatter = nil, -- Use default
      diff_opts = {
        internal = true,
      },
    },
    -- config = function(_, opts)
    --   require("gitsigns").setup(opts)
    -- end
  }
}
