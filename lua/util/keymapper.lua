local M = {}

local vim_modes = {
	n = "n",
	i = "i",
	v = "v",
}

local default_opts = {
	noremap = true,
	silent = true,
}

-- -@param lhs string
--- @param rhs (function|string)
--- @param options (table|nil)
--- @param vimmode (table|nil)
--- @return nil
M.map = function(lhs, rhs, options, vimmode)
    local mode = vimmode or {"n"}
	-- TODO check for valid mode in argument (local mode = vim_modes[vimmode] or "n")
	local opts = options or {}
	for k, v in pairs(default_opts) do
		opts[k] = opts[k] or v
	end
    for _, v in ipairs(mode) do
        vim.keymap.set(v, lhs, rhs, opts)
    end
end

return M
