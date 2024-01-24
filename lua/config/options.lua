vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.autoindent = true
vim.opt.background = "dark"
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.backup = false                                               -- creates a backup file
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.breakindent = true                                           -- Enable break indent
vim.opt.clipboard = "unnamedplus"                                    -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", } -- better completion
vim.opt.cursorcolumn = false                                         -- cursor line/column highlight
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.formatoptions:append({ "r" }) -- Add asterisks in block comments
vim.opt.guicursor = "i:ver25-iCursor"
vim.opt.hlsearch = true               -- highlight all matches on previous search pattern
vim.opt.ignorecase = true
vim.opt.inccommand = "split"
vim.opt.iskeyword:append("-")   -- hyphenated words recognized by searches
vim.opt.laststatus = 2
vim.opt.linebreak = true  -- companion to wrap, don't split words
vim.opt.listchars = { eol = "¬", tab = ">·", trail = "~", extends = ">", precedes = "<" } -- which list chars to schow
vim.opt.mouse = ""  -- "a" allow the mouse to be used in neovim
vim.opt.number = true
vim.opt.numberwidth = 4   -- set number column width to 2 {default 4}
vim.opt.path:append({ "**" })  -- Finding files - Search down into subfolders
vim.opt.relativenumber = true
vim.scriptencoding = "utf-8"
vim.opt.scrolloff = 5     -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`
vim.opt.shell = "/usr/bin/bash"
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.showcmd = true -- hide (partial) command in last line of screen
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.splitbelow = true -- split go below
vim.opt.splitkeep = "cursor"
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.wrap = false

-- setup statusline
vim.g.qf_disable_statusline = true
vim.o.statusline = "%{%v:lua.require'util.status-line'.generate()%}"

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[0m"]])

-- vim.opt.autowrite = true
-- vim.opt.autoread = true
-- vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
-- vim.opt.mousemoveevent = true

-- vim: ts=2 sts=2 sw=2 et
