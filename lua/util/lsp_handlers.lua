local lspconfig = require "lspconfig"
local lsp_zero = require "lsp-zero"

return {
    lsp_servers = {
        "bashls",
        "pyright",
        "lua_ls",
        "emmet_ls",
        "jsonls",
        "clangd",
        "gopls",
        "clangd",
        "beancount",
    },
    handlers = {
        lsp_zero.default_setup, -- default

        --- the name of the handler must be the same
        --- as the name of the language server
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            lspconfig.lua_ls.setup(lua_opts)
        end,
        -- lua_ls = function()
        --     lspconfig.lua_ls.setup {
        --         settings = { -- custom settings for lua
        --             Lua = {
        --                 -- make the language server recognize "vim" global
        --                 diagnostics = {
        --                     globals = { "vim" },
        --                 },
        --                 workspace = {
        --                     -- make language server aware of runtime files
        --                     library = {
        --                         [vim.fn.expand "$VIMRUNTIME/lua"] = true,
        --                         [vim.fn.stdpath "config" .. "/lua"] = true,
        --                     },
        --                 },
        --             },
        --         },
        --     }
        -- end,

        jsonls = function()
            lspconfig.jsonls.setup {
                filetypes = { "json", "jsonc" },
            }
        end,

        pyright = function()
            lspconfig.pyright.setup {
                settings = {
                    pyright = {
                        disableOrganizeImports = false,
                        analysis = {
                            useLibraryCodeForTypes = true,
                            autoSearchPaths = true,
                            diagnosticMode = "workspace",
                            autoImportCompletions = true,
                        },
                    },
                },
            }
        end,

        tsserver = function()
            lspconfig.tsserver.setup {
                filetypes = {
                    "typescript",
                },
                root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
            }
        end,

        bashls = function()
            lspconfig.bashls.setup {
                filetypes = { "sh", "aliasrc" },
            }
        end,

        -- typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
        emmet_ls = function()
            lspconfig.emmet_ls.setup {
                filetypes = {
                    "typescriptreact",
                    "javascriptreact",
                    "javascript",
                    "css",
                    "sass",
                    "scss",
                    "less",
                    "vue",
                    "html",
                },
            }
        end,

        dockerls = function()
            lspconfig.dockerls.setup {}
        end,

        clangd = function()
            lspconfig.clangd.setup {
                cmd = {
                    "clangd",
                    "--offset-encoding=utf-16",
                },
            }
        end,
    },
}
