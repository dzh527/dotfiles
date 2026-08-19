return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = function(_, opts)
      opts.flavour = "macchiato"
      opts.custom_highlights = function(colors)
        local separator = {
          fg = colors.mauve,
          bold = true,
        }

        return {
          WinSeparator = separator,
          VertSplit = separator,
          SnacksWinSeparator = separator,
        }
      end
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-macchiato",
    },
  },
}
