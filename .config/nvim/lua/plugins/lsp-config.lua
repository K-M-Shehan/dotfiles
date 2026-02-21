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
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local capabilities = vim.tbl_deep_extend( -- will compute capabilities once and reuse in handlers
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"clangd",
					"pyright",
					"rust_analyzer",
					"tailwindcss",
					"gopls",
					"csharp_ls",
				},
				handlers = {
					-- default handler for any server without a specific handler
					function(server)
						require("lspconfig")[server].setup({
							capabilities = capabilities,
						})
					end,
					-- lua ls
					lua_ls = function()
						require("lspconfig").lua_ls.setup({
							settings = {
								Lua = {
									diagnostics = { globals = { "vim" } },
									workspace = { checkThirdParty = false },
								},
							},
							capabilities = capabilities,
						})
					end,
					-- typscript ls
					ts_ls = function()
						require("lspconfig").ts_ls.setup({
							capabilities = capabilities,
						})
					end,
					-- html ls
					html = function()
						require("lspconfig").html.setup({
							capabilities = capabilities,
						})
					end,
					--css ls
					cssls = function()
						require("lspconfig").cssls.setup({
							capabilities = capabilities,
						})
					end,
					-- c ls
					clangd = function()
						require("lspconfig").clangd.setup({
							capabilities = capabilities,
						})
					end,
					-- python ls
					pyright = function()
						require("lspconfig").pyright.setup({
							settings = {
								python = {
									venvPath = ".",
									venv = ".venv",
								},
							},
							capabilities = capabilities,
						})
					end,
					-- rust ls
					rust_analyzer = function()
						require("lspconfig").rust_analyzer.setup({
							capabilities = capabilities,
							settings = {
								["rust-analyzer"] = {
									checkOnSave = {
										command = "clippy",
									},
								},
							},
						})
					end,
					-- go ls
					gopls = function()
						require("lspconfig").gopls.setup({
							capabilities = capabilities,
							settings = {
								gopls = {
									analyses = {
										unusedparams = true,
									},
									staticcheck = true,
								},
							},
						})
					end,
					-- c# ls
					csharp_ls = function()
						require("lspconfig").csharp_ls.setup({
							capabilities = capabilities,
              root_dir = function(bufnr, on_dir)
                local fname = vim.api.nvim_buf_get_name(bufnr)
                on_dir(
                  require("lspconfig.util").root_pattern("*.sln", "*.slnx", "*.csproj", ".git")(fname)
                  or vim.fn.getcwd()
                )
              end,
						})
					end,
					-- tailwind ls
					tailwindcss = function()
						require("lspconfig").tailwindcss.setup({
							capabilities = capabilities,
							filetypes = {
								"html",
								"css",
								"javascript",
								"javascriptreact",
								"typescript",
								"typescriptreact",
								"svelte",
								"vue",
							},
						})
					end,
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
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				update_in_insert = true,
			})
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			-- Scoped keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = function(desc)
						return { buffer = event.buf, desc = desc }
					end

					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover docs"))
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("References"))
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename"))
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts("Show diagnostic"))
          -- only format through null ls to avoid conflicts
					vim.keymap.set("n", "<leader>gf", function()
						vim.lsp.buf.format({
							async = true,
							filter = function(client)
                local filetype = vim.bo[event.buf].filetype
                if filetype == "rust" then
                  return client.name == "rust_analyzer"
                end
								return client.name == "null-ls"
							end,
						})
					end, opts("Format file"))
				end,
			})
		end,
	},
}
