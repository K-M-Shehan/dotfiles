require("config.remap")
print("Hello!")

-- Patch vim.fs.find to flatten nested string tables in `names`.
-- nvim-lspconfig passes nested tables (e.g. { markers1, markers2, {'.git'} })
-- for priority-based root detection when has('nvim-0.11.3')==1, but this
-- build's vim.fs.find only handles flat string[] and crashes in joinpath.
do
  local orig_find = vim.fs.find
  vim.fs.find = function(names, opts)
    if type(names) == "table" then
      local flat = {}
      local function flatten(t)
        for _, v in ipairs(t) do
          if type(v) == "table" then
            flatten(v)
          else
            flat[#flat + 1] = v
          end
        end
      end
      flatten(names)
      names = flat
    end
    return orig_find(names, opts)
  end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('config.globals')
require('config.options')

local opts = {
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "rose-pine" }
	},
	rtp = {
		disabled_plugins = {
			"gzip",
         		"matchit",
        		"matchparen",
        		"netrwPlugin",
       			"tarPlugin",
        		"tohtml",
        		"tutor",
        		"zipPlugin",
		}
	},
	change_detection = {
		notify = true,
	},
}

require("lazy").setup({
  spec = { import = "plugins" },
  opts
})
