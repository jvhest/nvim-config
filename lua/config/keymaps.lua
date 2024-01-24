local map = require("util.keymapper").map

map("<F12>", "<CMD>Explore<CR>", { desc = "Open Netrw explorer" })

map("<Space>", "<Nop>", { desc = "Better Default" }, { "n", "v" })
map("0", "^", { desc = "Jump to first non-blank char" })
map("x", '"_x', { desc = "Delete Char" })
map("<S-q>", "@q", { desc = "Play Macro in q reg" })
map("p", '"_dP', { desc = "Paste Replace without Copy" }, { "v" })
map(";;", "<Esc>A;<Esc>i", { desc = "Insert Trailing ;" }, { "i" })
map(",,", "<Esc>A,<Esc>i", { desc = "Insert Trailing ," }, { "i" })
map("<leader>cd", "<CMD>cd %:p:h<CR><CMD>pwd<CR>", { desc = "Set pwd" })

-- Edit neovim config
map("<leader>ce", "<CMD>e! ~/.config/nvim<CR>", { desc = "Edit nvim config" })
map("<leader>cs", "<CMD>source ~/.config/nvim/init.lua<CR>", { desc = "Source nvim config" })

-- better up/down
map("j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map("k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true })
map("<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Move to window using the <ctrl> hjkl keys
-- zie plugin: christoomey/vim-tmux-navigator  -- tmux & split window navigation

-- windows
map("<leader>wo", "<C-W>o", { desc = "Close other windows" })
map("<leader>ww", "<C-W>p", { desc = "Goto other window" })
map("<leader>wd", "<C-W>c", { desc = "Close window" })
map("<leader>w-", "<C-W>s", { desc = "Split window below" })
map("<leader>w|", "<C-W>v", { desc = "Split window right" })
map("<leader>-", "<C-W>s", { desc = "Split window below" })
map("<leader>|", "<C-W>v", { desc = "Split window right" })

-- Resize window using <ctrl> arrow keys
map("<C-Up>", "<CMD>resize +2<CR>", { desc = "Increase window height" })
map("<C-Down>", "<CMD>resize -2<CR>", { desc = "Decrease window height" })
map("<C-Left>", "<CMD>vertical resize -2<CR>", { desc = "Decrease window width" })
map("<C-Right>", "<CMD>vertical resize +2<CR>", { desc = "Increase window width" })

-- Move Lines
map("<A-j>", "<CMD>m .+1<CR>==", { desc = "Move down" })
map("<A-k>", "<CMD>m .-2<CR>==", { desc = "Move up" })
map("<A-j>", "<esc><cmd>m .+1<CR>==gi", { desc = "Move down" }, { "i" })
map("<A-k>", "<esc><cmd>m .-2<CR>==gi", { desc = "Move up" }, { "i" })
map("<A-j>", "<CMD>m '>+1<CR>gv=gv", { desc = "Move down" }, { "v" })
map("<A-k>", "<CMD>m '<-2<CR>gv=gv", { desc = "Move up" }, { "v" })

-- buffers
map("[b", "<CMD>bprevious<CR>", { desc = "Prev buffer" })
map("]b", "<CMD>bnext<CR>", { desc = "Next buffer" })
map("<leader>bb", "<CMD>e #<CR>", { desc = "Switch to Other Buffer" })
map("<leader>bc", "<CMD>bdelete!<CR>", { desc = "Close buffer" })
map("<leader>ba", "<CMD>bufdo bd<CR>", { desc = "Close all buffers" })
map("<leader>`", "<CMD>e #<CR>", { desc = "Switch to Other Buffer" })
map("<leader>cd", "<CMD>cd %:p:h<CR><CMD>pwd<CR>", { desc = "Switch CWD to curr buffer's dir " })

map("<leader>bd", "<CMD>Bclose<CR><CMD>tabclose<CR>gT", { desc = "Close current buffer" })

-- Useful mappings for managing tabs
map("<leader>tn", "<CMD>tabnew<cr>", { desc = "Create new tab" })
map("<leader>to", "<CMD>tabonly<cr>", { desc = "Close other tabs" })
map("<leader>tc", "<CMD>tabclose<cr>", { desc = "Close current tab" })
map("<leader>tm", "<CMD>tabmove ", { desc = "Move tab" })
map("]t", "<CMD>tabnext<CR>", { desc = "Next tab" })
map("]t", "<CMD>tabprev<CR>", { desc = "Prev tab" })
map("<leader>te", '<CMD>tabedit <C-r>=escape(expand("%:p:h"), " ")<CR>/', { desc = "New tab with curr buffer's path" })

-- Clear search with <esc>
map("<esc>", "<CMD>noh<CR><esc>", { desc = "Escape and clear hlsearch" }, { "n", "i" })

map("gw", "*N", { desc = "Search word under cursor" }, { "n", "i" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" }, { "n", "x", "o" })
map("N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" }, { "n", "x", "o" })

-- save file
map("<C-s>", "<CMD>w<CR><esc>", { desc = "Save file" }, { "n", "v", "i", "s" })

-- better indenting
map("<", "<gv", { desc = "Dedent line" }, { "v" })
map(">", ">gv", { desc = "Indent line" }, { "v" })

-- lazy
map("<leader>l", "<CMD>Lazy<CR>", { desc = "Lazy update" })

-- new file
map("<leader>fn", "<CMD>enew<CR>", { desc = "New File" })

map("<leader>xl", "<CMD>lopen<CR>", { desc = "Location List" })
map("<leader>xq", "<CMD>copen<CR>", { desc = "Quickfix List" })

-- used with Ttouble plugin
map("[q", "<CMD>cprev<CR>", { desc = "Previous quickfix" })
map("]q", "<CMD>cnext<CR>", { desc = "Next quickfix" })

-- toggle options
-- map("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
map("<leader>ul", function()
    require("util.toggle").toggle_line_numbers()
end, { desc = "Toggle Line numbers" })
map("<leader>ud", function()
    require("util.toggle").toggle_diagnostics()
end, { desc = "Toggle Diagnostics" })
map("<leader>us", function()
    require("util.toggle").toggle "spell"
end, { desc = "Toggle Spelling" })
map("<leader>uw", function()
    require("util.toggle").toggle "wrap"
end, { desc = "Toggle Word Wrap" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("<leader>uc", function()
    Util.toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- quit
map("<leader>qq", "<CMD>qa<CR>", { desc = "Quit all" })
map("<leader>fq", "<CMD>qa!<CR>", { desc = "Quit all forced!" })

-- fixed terminal
map("<leader>T", "<Esc><CMD>new<CR><CMD>resize 10<CR><CMD>term<CR>", { desc = "Open terminal" })
map("<Esc>", "<C-\\><C-N><C-w>c", { desc = "Close terminal" }, { "t" })
map("<C-h>", "<C-\\><C-N><C-w>h", { desc = "Nav Left from Terminal" }, { "t" })
map("<C-j>", "<C-\\><C-N><C-w>j", { desc = "Nav Down from Terminal" }, { "t" })
map("<C-k>", "<C-\\><C-N><C-w>k", { desc = "Nav Up from Terminal" }, { "t" })
map("<C-l>", "<C-\\><C-N><C-w>l", { desc = "Nav Right from Terminal" }, { "t" })

-- navigate / center
map("<C-d>", "<C-d>zz", { desc = "Page Down and Center" })
map("<C-u>", "<C-u>zz", { desc = "Page Up and Center" })
map("n", "nzzzv", { desc = "Next Selection and Center" })
map("N", "Nzzzv", { desc = "Prev selection and Center" })

-- Diagnostic keymaps
--TODO check telescope diagnostics?
map("[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map("]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map("<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
