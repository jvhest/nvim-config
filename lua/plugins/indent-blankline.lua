return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        indent = {
            char = "┊",
        },
        whitespace = {
            remove_blankline_trail = true,
        },
        scope = {
            enabled = true,
            char = "╏",
            show_start = false,
            show_end = false,
        },
    },
}
