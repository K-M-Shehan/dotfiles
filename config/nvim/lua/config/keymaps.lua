local keymap = vim.keymap

-- Directory Navigation

-- Pane and Window Navigation
keymap.set("<C-h>", "<C-w>h", "n") -- Navigate Left
keymap.set("<C-j>", "<C-w>j", "n") -- Navigate Down
keymap.set("<C-k>", "<C-w>k", "n") -- Navigate Up
keymap.set("<C-l>", "<C-w>l", "n") -- Navigate Right

-- Indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Comments
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false })
