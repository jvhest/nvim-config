local map = require("util.keymapper").map

return {

    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
        },
    },
    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "L3MON4D3/LuaSnip" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
        },
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        config = false,
        dependencies = {
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },
            { "hrsh7th/nvim-cmp" },
        },
        init = function()
            local lsp_zero = require "lsp-zero"

            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps {
                    buffer = bufnr,
                    preserve_mappings = false,
                }
                if client.name == "pyright" then
                    map("<leader>oi", "<CMD>PyrightOrganizeImports<CR>", { buffer = bufnr, desc = "organise imports" })
                    map("<leader>db", "<CMD>DapToggleBreakpoint<CR>", { buffer = bufnr, desc = "toggle breakpoint" })
                    map("<leader>dr", "<CMD>DapContinue<CR>", { buffer = bufnr, desc = "continue/invoke debugger" })
                    map(
                        "<leader>dt",
                        "<CMD>lua require('dap-python').test_method()<CR>",
                        { buffer = bufnr, desc = "run tests" }
                    )
                end
            end)

            require("mason").setup {
                ui = { border = "rounded" },
            }

            require("mason-lspconfig").setup {
                ensure_installed = require("util.lsp_handlers").lsp_servers,
                automatic_installation = true,
                handlers = require("util.lsp_handlers").handlers,
            }

            -- Completion
            local cmp = require "cmp"
            local cmp_format = require("lsp-zero").cmp_format()
            local cmp_action = require("lsp-zero").cmp_action()

            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup {
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert {
                    -- `Enter` key to confirm completion
                    ["<CR>"] = cmp.mapping.confirm { select = false },

                    -- Ctrl+Space to trigger completion menu
                    ["<C-Space>"] = cmp.mapping.complete(),

                    -- Navigate between snippet placeholder
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),

                    -- Scroll up and down in the completion documentation
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),

                    -- Regular tab complete
                    ["<Tab>"] = cmp_action.tab_complete(),
                    ["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                -- (Optional) Show source name in completion menu
                formatting = cmp_format,
            }
        end,
    },
}
