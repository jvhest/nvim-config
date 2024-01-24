-- [[ Autocommands ]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

vim.cmd [[ autocmd FileType toml setlocal ts=2 sts=2 sw=2 expandtab indentexpr= ]]
vim.cmd [[ autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentexpr= ]]
vim.cmd [[ autocmd FileType yml setlocal ts=2 sts=2 sw=2 expandtab indentexpr= ]]
vim.cmd [[ autocmd FileType python setlocal foldmethod=indent ]]
vim.cmd [[ autocmd TermOpen * setlocal statusline=%{b:term_title} ]]
vim.cmd [[ autocmd TermOpen * startinsert ]]

-- Per default, netrw leaves unmodified buffers open.  This autocommand
-- deletes netrw's buffer once it's hidden (using ':q;, for example)
vim.cmd [[autocmd FileType netrw setlocal bufhidden=delete]]

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- go to last loc when opening a buffer
local generalGrp = augroup("General", { clear = true })
autocmd("BufReadPost", {
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
    group = generalGrp,
})

-- don't auto comment new line
autocmd("BufEnter", {
    command = [[set formatoptions-=cro]],
    group = generalGrp,
})

-- windows to close with "q"
local quickCloseGrp = augroup("QuickClose", { clear = true })
autocmd("FileType", {
    pattern = { "help", "startuptime", "qf", "fugitive", "null-ls-info", "dap-float" },
    command = [[nnoremap <buffer><silent> q :close<CR>]],
    group = quickCloseGrp,
})
autocmd("FileType", {
    pattern = { "man" },
    command = [[nnoremap <buffer><silent> q :quit<CR> ]],
    group = quickCloseGrp,
})
autocmd("FileType", {
    pattern = { "netrw" },
    command = [[nnoremap <buffer><silent> q :bd<CR> ]],
    group = quickCloseGrp,
})
