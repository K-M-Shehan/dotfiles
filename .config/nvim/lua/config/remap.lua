
vim.g.mapleader = " ";
-- got oil so this command is not used anymore
--vim.keymap.set("n", "<leader>hv", vim.cmd.Ex)
-- the new command set to the same key-binding
vim.keymap.set('n', '<leader>hv', "<CMD>Oil --float<CR>", { desc = "Open parent directory"} )

-- lua map
vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')
