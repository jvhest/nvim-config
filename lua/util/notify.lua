local M = {}

--- Telescope Wrapper around vim.notify
---@param title string: name of the function that will be
---@param opts table: opts.level string, opts.msg string, opts.once bool
M.notify = function(title, opts)
  opts.once = vim.F.if_nil(opts.once, false)
  local level = vim.log.levels[opts.level]
  if not level then
    error("Invalid error level", 2)
  end
  local notify_fn = opts.once and vim.notify_once or vim.notify
  notify_fn(string.format("[%s]: %s", title, opts.msg), level, {})
end

-- function M.notify(msg, opts)
--   opts = opts or {}
--   if type(msg) == "table" then
--     msg = table.concat(
--       vim.tbl_filter(function(line)
--         return line or false
--       end, msg),
--       "\n"
--     )
--   end
--   local lang = opts.lang or "markdown"
--   local n = opts.once and vim.notify_once or vim.notify
--   n(msg, opts.level or vim.log.levels.INFO, {
--     on_open = function(win)
--       local ok = pcall(function()
--         vim.treesitter.language.add("markdown")
--       end)
--       if not ok then
--         pcall(require, "nvim-treesitter")
--       end
--       vim.wo[win].conceallevel = 3
--       vim.wo[win].concealcursor = ""
--       vim.wo[win].spell = false
--       local buf = vim.api.nvim_win_get_buf(win)
--       if not pcall(vim.treesitter.start, buf, lang) then
--         vim.bo[buf].filetype = lang
--         vim.bo[buf].syntax = lang
--       end
--     end,
--   })
-- end

-- function M.error(msg, opts)
--   opts = opts or {}
--   opts.level = vim.log.levels.ERROR
--   M.notify('[ERROR] ' .. msg, opts)
-- end

-- function M.info(msg, opts)
--   opts = opts or {}
--   opts.level = vim.log.levels.INFO
--   M.notify('[INFO] ' .. msg, opts)
-- end

-- function M.warn(msg, opts)
--   opts = opts or {}
--   opts.level = vim.log.levels.WARN
--   M.notify('[WARN] ' .. msg, opts)
-- end

return M
