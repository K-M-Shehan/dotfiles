
vim.g.mapleader = " ";
-- got oil so this command is not used anymore
--vim.keymap.set("n", "<leader>hv", vim.cmd.Ex)
-- the new command set to the same key-binding
vim.keymap.set('n', '<leader>hv', "<CMD>Oil --float<CR>", { desc = "Open parent directory"} )
