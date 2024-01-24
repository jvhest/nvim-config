return {
    "b0o/incline.nvim",
    event = "BufReadPre",
    -- priority = 1200,
    config = function()
        require("incline").setup({
        highlight = {
            groups = {
            InclineNormal = { guifg = "#EEE8D5" },
            InclineNormalNC = { guifg = "#EEE8D5" },
            },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
            cursorline = true,
        },
        render = function(props)
            local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
            if vim.bo[props.buf].modified then
                filename = "[+] " .. filename
            end
            return { { " " }, { filename } }
        end,
        })
    end,
}
