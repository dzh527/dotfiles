return {
  {
    "folke/tokyonight.nvim",
    opts = function(_, opts)
      local on_highlights = opts.on_highlights

      opts.on_highlights = function(highlights, colors)
        if on_highlights then
          on_highlights(highlights, colors)
        end

        local separator = {
          fg = colors.magenta,
          bold = true,
        }

        highlights.WinSeparator = separator
        highlights.VertSplit = separator
        highlights.SnacksWinSeparator = separator
      end
    end,
  },
}
