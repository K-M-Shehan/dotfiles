return {
  "goolord/alpha-nvim",
  lazy = false,
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    -- Set header
    dashboard.section.header.val = {
      --     "                                                       ",
      --     "      ██╗ ██████╗ ██╗   ██╗██████╗  ██████╗ ██╗   ██╗  ",
      --     "      ██║██╔═══██╗╚██╗ ██╔╝██╔══██╗██╔═══██╗╚██╗ ██╔╝  ",
      --     "      ██║██║   ██║ ╚████╔╝ ██████╔╝██║   ██║ ╚████╔╝   ",
      --     " ██   ██║██║   ██║  ╚██╔╝  ██╔══██╗██║   ██║  ╚██╔╝    ",
      --     " ╚█████╔╝╚██████╔╝   ██║   ██████╔╝╚██████╔╝   ██║     ",
      --     "  ╚════╝  ╚═════╝    ╚═╝   ╚═════╝  ╚═════╝    ╚═╝     ",
      --     "                                                       ",

      "                                                      ",
      "    ▄▄▄██▀▀▀▒█████ ▓██   ██▓ ▄▄▄▄    ▒█████ ▓██   ██▓ ",
      "      ▒██  ▒██▒  ██▒▒██  ██▒▓█████▄ ▒██▒  ██▒▒██  ██▒ ",
      "      ░██  ▒██░  ██▒ ▒██ ██░▒██▒ ▄██▒██░  ██▒ ▒██ ██░ ",
      "   ▓██▄██▓ ▒██   ██░ ░ ▐██▓░▒██░█▀  ▒██   ██░ ░ ▐██▓░ ",
      "    ▓███▒  ░ ████▓▒░ ░ ██▒▓░░▓█  ▀█▓░ ████▓▒░ ░ ██▒▓░ ",
      "    ▒▓▒▒░  ░ ▒░▒░▒░   ██▒▒▒ ░▒▓███▀▒░ ▒░▒░▒░   ██▒▒▒  ",
      "    ▒ ░▒░    ░ ▒ ▒░ ▓██ ░▒░ ▒░▒   ░   ░ ▒ ▒░ ▓██ ░▒░  ",
      "    ░ ░ ░  ░ ░ ░ ▒  ▒ ▒ ░░   ░    ░ ░ ░ ░ ▒  ▒ ▒ ░░   ",
      "    ░   ░      ░ ░  ░ ░      ░          ░ ░  ░ ░      ",
      "                    ░ ░           ░          ░ ░      ",
      "                                                      ",
    }

    -- Set footer
    local lazy_stats = require("lazy").stats() -- Get Lazy.nvim stats
    dashboard.section.footer.val = {
      "If You Don't Take Risks, You Can't Create a Future.",
      " ",
      "                                  - Monkey D. Luffy",
      " ",
      "             Plugins loaded: " .. lazy_stats.loaded .. " / " .. lazy_stats.count,
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[
      autocmd FileType alpha setlocal nofoldenable
    ]])
  end,
}
