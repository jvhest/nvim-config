local M = {}

M.create_term_buf = function(position, size)
    vim.opt.splitbelow = true
    vim.opt.splitright = true
    if position == "v" then
        vim.cmd [[vnew]]
    else
        vim.cmd [[new]]
    end
    local cmd = string.format("resize [%d]", size)
    vim.cmd(cmd)
end

return M
