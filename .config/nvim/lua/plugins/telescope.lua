local keymap = vim.keymap

local config = function()
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewer = true,
        hidden = true,
      },
      live_grep = {
        theme = "dropdown",
        previewer = true,
      },
      buffers = {
        theme = "dropdown",
        previewer = true,
      },
    },
    extensions = {
      fzf = {},
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
    },
  })
  -- load the extensions after setting up Telescope
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("ui-select")
end

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  --  branch = "0.1.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = config,
  keys = {
    keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>"),
    keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>"),
    keymap.set("n", "<leader>ff", ":Telescope find_files<CR>"),
    keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>"),
    keymap.set("n", "<leader>fb", ":Telescope buffers<CR>"),
  },
}
