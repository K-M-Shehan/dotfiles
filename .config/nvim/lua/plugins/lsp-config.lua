return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
		lazy = false,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "html", "cssls", "clangd" },
				handlers = {
					function(server)
						require("lspconfig")[server].setup({
							capabilities = vim.tbl_deep_extend(
								"force",
								{},
								vim.lsp.protocol.make_client_capabilities(),
								require("cmp_nvim_lsp").default_capabilities()
							),
						})
					end,
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							settings = {
								Lua = {
									diagnostics = { globals = { "vim" } },
									workspace = { checkThirdParty = false },
								},
							},
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
						})
					end,
					ts_ls = function()
						require("lspconfig").ts_ls.setup({
							capabilities = require("cmp_nvim_lsp").default_capabilities(),
						})
					end,
          html = function()
            require("lspconfig").html.setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
          end,
          cssls = function()
            require("lspconfig").cssls.setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
          end,
          clangd = function ()
            require("lspconfig").clangd.setup({
              capabilities = require("cmp_nvim_lsp").default_capabilities(),
              cmd = { "clangd", "--background-index" },
            })
          end
				},
			})
		end,
		lazy = false,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			-- LSP UI tweaks
			vim.diagnostic.config({
        float = { border = "rounded" },
        virtual_text = true,
        signs = true,
        update_in_insert = true,
      })
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			-- Scoped keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>gf", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
	},
}
