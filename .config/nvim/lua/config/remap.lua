
vim.g.mapleader = " ";
-- got oil so this command is not used anymore
--vim.keymap.set("n", "<leader>hv", vim.cmd.Ex)
-- the new command set to the same key-binding
vim.keymap.set('n', '<leader>hv', "<CMD>Oil --float<CR>", { desc = "Open parent directory"} )

-- lua map
vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')

-- Yank to clipboard
vim.keymap.set('n', 'y', '"+y', { noremap = true })
vim.keymap.set('v', 'y', '"+y', { noremap = true })
vim.keymap.set('n', 'yy', '"+yy', { noremap = true })
vim.keymap.set('n', 'p', '"+p', { noremap = true })
vim.keymap.set('n', 'P', '"+P', { noremap = true })
