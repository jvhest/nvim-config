Util = require("util.notify")

local M = {}

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
    if values then
        if vim.opt_local[option]:get() == values[1] then
            vim.opt_local[option] = values[2]
        else
            vim.opt_local[option] = values[1]
        end
        -- return Util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
        Util.notify('toggle', {
            msg = "Set " .. option .. " to " .. vim.opt_local[option]:get(),
            level = 'INFO'
        })
        return
    end
    vim.opt_local[option] = not vim.opt_local[option]:get()
    if not silent then
        if vim.opt_local[option]:get() then
            Util.notify('toggle', {
                msg = 'Enabled ' .. option,
                level = 'WARN'
            })
        else
            Util.notify('toggle', {
                msg = 'Disabled ' .. option,
                level = 'WARN'
            })
        end
    end
end

local diag_enabled = true
function M.toggle_diagnostics()
    diag_enabled = not diag_enabled
    if diag_enabled then
        vim.diagnostic.enable()
        Util.notify("Diagnostics", {
            msg = 'Enabled',
            level = 'INFO'
        })
        -- Util.info("Enabled diagnostics", { title = "Diagnostics" })
    else
        Util.notify("Diagnostics", {
            msg = 'Disabled',
            level = 'INFO'
        })
        vim.diagnostic.disable()
        -- Util.warn("Disabled diagnostics", { title = "Diagnostics" })
    end
end

function M.toggle_line_numbers()
    local num = vim.opt.number:get()
    local rnum = vim.opt.relativenumber:get()
    -- num is true
    if num then
        vim.opt.number = false
        vim.opt.relativenumber = true
        Util.notify("Line numbers", {
            msg = 'Enabled relative line numbers',
            level = 'INFO'
        })
        -- Util.info("Enabled relative line numbers", { title = "Line numbers" })
        return
    else
        -- num is false
        if rnum then
            vim.opt.relativenumber = false
            -- Util.info("Disabled line numbers", { title = "Line numbers" })
            Util.notify("Line numbers", {
                msg = 'Disabled line numbers',
                level = 'INFO'
            })
        else
            -- num is false and rnum is false
            vim.opt.number = true
            Util.notify("Line numbers", {
                msg = 'Enabled line numbers',
                level = 'INFO'
            })
            -- Util.info("Enabled line numbers", { title = "Line numbers" })
        end
    end
end

return M
