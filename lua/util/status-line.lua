local M = {}

-- Vim options:
vim.opt.showmode = false

-- Highlights statusline
-- vim.cmd('highlight HiStatusLine1 guibg=#8aadf4 guifg=#1e2137')
-- vim.cmd('highlight HiStatusLine2 guibg=#494d64 guifg=#7080b4')
-- vim.cmd('highlight HiStatusLine3 guibg=#1e2030 guifg=#c8d3f4')
-- vim.cmd('highlight HiStatusLine4 guibg=#1e2030 guifg=#5af78c')

vim.api.nvim_set_hl(0, "HiStatusLine1", { bg="#8aadf4", fg="#1e2137"} )
vim.api.nvim_set_hl(0, "HiStatusLine2", { bg="#494d64", fg="#7080b4" })
vim.api.nvim_set_hl(0, "HiStatusLine3", { bg="#1e2030", fg="#c8d3f4" })
vim.api.nvim_set_hl(0, "HiStatusLine4", { bg="#1e2030", fg="#5af78c" })

-- used colors
local COLOR1 = "%#HiStatusLine1#"
local COLOR2 = "%#HiStatusLine2#"
local COLOR3 = "%#HiStatusLine3#"
local COLOR4 = "%#HiStatusLine4#"

-- TODO Show virtualenv path when in python project
-- see: https://github.com/jdhao/nvim-config/blob/master/lua/config/statusline.lua
local virtual_env = function()
  -- only show virtual env for Python
  if vim.bo.filetype ~= 'python' then
    return ""
  end

  local conda_env = os.getenv('CONDA_DEFAULT_ENV')
  local venv_path = os.getenv('VIRTUAL_ENV')

  if venv_path == nil then
    if conda_env == nil then
      return ""
    else
      return string.format("  %s (conda)   | ", conda_env)
    end
  else
    local venv_name = vim.fn.fnamemodify(venv_path, ':t')
    return string.format("  %s (venv)   | ", venv_name)
  end
end

-- Vim-modes
-- see: https://github.com/famiu/feline.nvim/blob/master/lua/feline/providers/vi_mode.lua
local mode_alias = {
  ['n'] = 'NORMAL',
  ['no'] = 'OP',
  ['nov'] = 'OP',
  ['noV'] = 'OP',
  ['no'] = 'OP',
  ['niI'] = 'NORMAL',
  ['niR'] = 'NORMAL',
  ['niV'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['vs'] = 'VISUAL',
  ['V'] = 'LINES',
  ['Vs'] = 'LINES',
  [''] = 'BLOCK',
  ['s'] = 'BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'SELECT',
  [''] = 'BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rc'] = 'REPLACE',
  ['Rv'] = 'V-REPLACE',
  ['Rx'] = 'REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'COMMAND',
  ['ce'] = 'COMMAND',
  ['r'] = 'ENTER',
  ['rm'] = 'MORE',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERM',
  ['nt'] = 'TERM',
  ['null'] = 'NONE',
}

-- Vim-mode
-- Maximum possible length for a mode name (used for padding)
local mode_name_max_length = math.max(unpack(vim.tbl_map(function(str)
  return #str
end, vim.tbl_values(mode_alias))))

-- Vim-mode provider
local function vi_mode()
  local str = mode_alias[vim.api.nvim_get_mode().mode]
  local padding_length = mode_name_max_length - #str

  return COLOR1
      .. string.rep(' ', math.floor(padding_length / 2))
      .. str
      .. string.rep(' ', math.ceil(padding_length / 2))
end

-- Diagnostics
-- see: https://github.com/famiu/feline.nvim/blob/master/lua/feline/providers/lsp.lua
local function read_diagnostics(severity)
  local count = vim.tbl_count(vim.diagnostic.get(0, severity and { severity = severity }))
  return count ~= 0 and tostring(count) or ''
end

local function diagnostic_errors()
  local count = read_diagnostics(vim.diagnostic.severity.ERROR)
  return count ~= '' and ' ' .. count .. '  ' or ''
end

local function diagnostic_warnings()
  local count = read_diagnostics(vim.diagnostic.severity.WARN)
  return count ~= '' and ' ' .. count .. '  ' or ''
end

local function diagnostic_info()
  local count = read_diagnostics(vim.diagnostic.severity.INFO)
  return count ~= '' and ' ' .. count .. '  ' or ''
end

local function diagnostic_hints()
  local count = read_diagnostics(vim.diagnostic.severity.HINT)
  return count ~= '' and ' ' .. count .. '  ' or ''
end

-- Diagnostics provider
local function diagnostics()
  local provider = diagnostic_errors() .. diagnostic_warnings() .. diagnostic_info() .. diagnostic_hints()
  return provider ~= '' and COLOR4 .. provider .. COLOR3 or ''
end

-- Git branch provider
local function git_branch()
  local head = vim.b.gitsigns_head or ''
  return head ~= '' and COLOR2 .. string.format('  %s ', head) or ''
end

-- Git branch + status provider
local function git_branch_all()
  local signs = vim.b.gitsigns_status_dict or { head = '', added = 0, changed = 0, removed = 0 }
  return signs.head ~= '' and COLOR2 .. string.format(
    ' +%s ~%s -%s |  %s ',
    signs.added, signs.changed, signs.removed, signs.head) or ''
end

local function modified()
  local fstatus = "           "
  if vim.bo.readonly then fstatus = "  [RO]     " end
  if vim.bo.modified then fstatus = "  [+]      " end
  return fstatus
end

-- Other providers
local file_name = " %f"
-- local modified = "  %-5m"
local align_right = "%="
local fileencoding = "| %{&fileencoding?&fileencoding:&encoding} "
local fileformat = "| %{&fileformat} "
local filetype = " %Y "
local percentage = " %3p%% "
local linecol = " %4l:%-3c"

function M.generate()
  return string.format(
    "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
    -- left hand side
    vi_mode(),
    git_branch_all(),
    COLOR3,
    file_name,
    modified(),
    diagnostics(),
    -- right hand side
    align_right,
    virtual_env(),
    filetype,
    fileencoding,
    fileformat,
    COLOR2,
    percentage,
    COLOR1,
    linecol
  )
end

return M

-- vim: ts=2 sts=2 sw=2 et
