return {
    "nvimtools/none-ls.nvim", -- configure formatters & linters
    -- lazy = true,
    event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local mason_null_ls = require "mason-null-ls"

        local null_ls = require "null-ls"

        local null_ls_utils = require "null-ls.utils"

        mason_null_ls.setup {
            ensure_installed = {
                "eslint_d",
                "prettier",
                "shellcheck",
                "shfmt",
                "luacheck",
                "stylua",
                "flake8",
                "black",
                "isort",
                "cpplint",
                "clang-format",
            },
        }

        -- for conciseness
        local formatting = null_ls.builtins.formatting -- to setup formatters
        local diagnostics = null_ls.builtins.diagnostics -- to setup linters

        -- to setup format on save
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        -- configure null_ls
        null_ls.setup {
            -- add package.json as identifier for root (for typescript monorepos)
            root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
            -- setup formatters & linters
            sources = {
                -- 'html', 'css', 'javascript', 'typescript', 'docker', 'markdown'
                diagnostics.eslint_d.with {
                    condition = function(utils)
                        return utils.root_has_file { ".eslintrc.js", ".eslintrc.cjs" } -- only enable if root has .eslintrc.js or .eslintrc.cjs
                    end,
                },
                formatting.prettier.with {
                    extra_filetypes = { "svelte" },
                    disabled_filetypes = {},
                },
                -- sh
                diagnostics.shellcheck,
                formatting.shfmt,
                -- lua
                diagnostics.luacheck.with {
                    extra_args = { "--globals vim" }, -- filters warning of undefined variable 'vim'
                },
                formatting.stylua,
                -- python
                diagnostics.flake8.with {
                    extra_args = { "--max-line-length=88" },
                },
                formatting.black.with {
                    extra_args = { "--fast", "-l 88" },
                },
                formatting.isort,
                -- c, cpp
                diagnostics.cpplint,
                formatting.ccp_formater,
            },
            -- configure format on save
            -- you can reuse a shared lspconfig on_attach callback here
            on_attach = function(current_client, bufnr)
                if current_client.supports_method "textDocument/formatting" then
                    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                            -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                            vim.lsp.buf.format {
                                async = false,
                                filter = function(client)
                                    --  only use null-ls for formatting instead of lsp server
                                    return client.name == "null-ls"
                                end,
                            }
                        end,
                    })
                end
            end,
        }
    end,
}
