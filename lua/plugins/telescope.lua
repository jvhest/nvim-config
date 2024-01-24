-- Utils = require('utils.utils')

-- local Util = require("lazy.core.util")

local root_patterns = { ".git", "lua" }

-- ---@param plugin string
-- function M.has(plugin)
--     return require("lazy.core.config").plugins[plugin] ~= nil
-- end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
local function get_root()
    ---@type string?
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.loop.fs_realpath(path) or nil
    ---@type string[]
    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
            local workspace = client.config.workspace_folders
            local paths = workspace
                    and vim.tbl_map(function(ws)
                        return vim.uri_to_fname(ws.uri)
                    end, workspace)
                or client.config.root_dir and { client.config.root_dir }
                or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    ---@type string?
    local root = roots[1]
    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        ---@type string?
        root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    ---@cast root string
    return root
end

-- Othis will return a function that calls telescope.
--
-- cwd will default to lazyvim.util.get_root
-- for `files`, git_files or find_files will be chosen depending on .git
local function telescope(builtin, opts)
    local params = { builtin = builtin, opts = opts }
    return function()
        builtin = params.builtin
        opts = params.opts
        opts = vim.tbl_deep_extend("force", { cwd = get_root() }, opts or {})
        if builtin == "files" then
            if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
                opts.show_untracked = true
                builtin = "git_files"
            else
                builtin = "find_files"
            end
        end
        require("telescope.builtin")[builtin](opts)
    end
end

return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
        { "<leader>,", "<CMD>Telescope buffers show_all_buffers=true<CR>", desc = "Switch Buffer" },
        { "<leader>/", telescope "live_grep", desc = "Grep (root dir)" },
        { "<leader>:", "<CMD>Telescope command_history<CR>", desc = "Command History" },
        { "\\\\", "<CMD>Telescope buffers<CR>", desc = "Buffers" },
        -- find
        { "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "Buffers" },
        { "<leader>ff", telescope "files", desc = "Find Files (root dir)" },
        { "<leader>fF", telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
        { "<leader>fr", "<CMD>Telescope oldfiles<CR>", desc = "Recent" },
        -- git
        { "<leader>gc", "<CMD>Telescope git_commits<CR>", desc = "commits" },
        { "<leader>gs", "<CMD>Telescope git_status<CR>", desc = "status" },
        -- search
        { "<leader>sa", "<CMD>Telescope autocommands<CR>", desc = "Auto Commands" },
        { "<leader>sb", "<CMD>Telescope current_buffer_fuzzy_find<CR>", desc = "Buffer" },
        { "<leader>sc", "<CMD>Telescope command_history<CR>", desc = "Command History" },
        { "<leader>sC", "<CMD>Telescope commands<CR>", desc = "Commands" },
        { "<leader>sd", "<CMD>Telescope diagnostics bufnr=0<CR>", desc = "Document diagnostics" },
        { "<leader>sD", "<CMD>Telescope diagnostics<CR>", desc = "Workspace diagnostics" },
        { "<leader>sg", telescope "live_grep", desc = "Grep (root dir)" },
        { "<leader>sG", telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
        { "<leader>sh", "<CMD>Telescope help_tags<CR>", desc = "Help Pages" },
        { "<leader>sH", "<CMD>Telescope highlights<CR>", desc = "Search Highlight Groups" },
        { "<leader>sk", "<CMD>Telescope keymaps<CR>", desc = "Key Maps" },
        { "<leader>sM", "<CMD>Telescope man_pages<CR>", desc = "Man Pages" },
        { "<leader>sm", "<CMD>Telescope marks<CR>", desc = "Jump to Mark" },
        { "<leader>so", "<CMD>Telescope vim_options<CR>", desc = "Options" },
        { "<leader>sR", "<CMD>Telescope resume<CR>", desc = "Resume" },
        { "<leader>sw", telescope "grep_string", desc = "Word (root dir)" },
        { "<leader>sW", telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
        {
            "<leader>uC",
            telescope("colorscheme", { enable_preview = true }),
            desc = "Colorscheme with preview",
        },
        {
            "<leader>ss",
            telescope("lsp_document_symbols", {
                symbols = {
                    "Class",
                    "Function",
                    "Method",
                    "Constructor",
                    "Interface",
                    "Module",
                    "Struct",
                    "Trait",
                    "Field",
                    "Property",
                },
            }),
            desc = "Goto Symbol",
        },
        {
            "<leader>sS",
            telescope("lsp_dynamic_workspace_symbols", {
                symbols = {
                    "Class",
                    "Function",
                    "Method",
                    "Constructor",
                    "Interface",
                    "Module",
                    "Struct",
                    "Trait",
                    "Field",
                    "Property",
                },
            }),
            desc = "Goto Symbol (Workspace)",
        },
    },
    opts = {
        defaults = {
            prompt_prefix = " ",
            selection_caret = " ",
            mappings = {
                i = {
                    -- ["<c-t>"] = function(...)
                    --   return require("trouble.providers.telescope").open_with_trouble(...)
                    -- end,
                    -- ["<a-t>"] = function(...)
                    --   return require("trouble.providers.telescope").open_selected_with_trouble(...)
                    -- end,
                    ["<a-i>"] = function()
                        telescope("find_files", { no_ignore = true })()
                    end,
                    ["<a-h>"] = function()
                        telescope("find_files", { hidden = true })()
                    end,
                    ["<C-Down>"] = function(...)
                        return require("telescope.actions").cycle_history_next(...)
                    end,
                    ["<C-Up>"] = function(...)
                        return require("telescope.actions").cycle_history_prev(...)
                    end,
                    ["<C-f>"] = function(...)
                        return require("telescope.actions").preview_scrolling_down(...)
                    end,
                    ["<C-b>"] = function(...)
                        return require("telescope.actions").preview_scrolling_up(...)
                    end,
                },
                n = {
                    ["q"] = function(...)
                        return require("telescope.actions").close(...)
                    end,
                },
            },
        },
    },
}

-- vim: ts=2 sts=2 sw=2 et
