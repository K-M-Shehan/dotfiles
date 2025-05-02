return {
  "nvimtools/none-ls.nvim",
  lazy = false,
  config = function()
    local null_ls = require("null-ls")
    local h = require("null-ls.helpers")

    -- Custom HTMLHint diagnostic source
    local htmlhint = {
      method = null_ls.methods.DIAGNOSTICS,
      filetypes = { "html" },
      generator = h.generator_factory({
        command = "htmlhint",
        args = { "--format", "json", "$FILENAME" },
        to_stdin = false,
        from_stderr = false,
        format = "json",
        check_exit_code = function(code)
          return code <= 1
        end,
        on_output = function(params)
          local diagnostics = {}
          local results = params.output and params.output[1] and params.output[1].messages or {}
          for _, err in ipairs(results) do
            table.insert(diagnostics, {
              row = err.line,
              col = err.col,
              message = err.message,
              severity = err.type == "error" and 1 or 2,
              source = "htmlhint",
            })
          end
          return diagnostics
        end,
      }),
    }

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        htmlhint,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
