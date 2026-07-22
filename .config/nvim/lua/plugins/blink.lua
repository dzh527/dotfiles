return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super_tab",
        ["<Tab>"] = {
          "select_and_accept",
          "snippet_forward",
          "fallback",
        },
      },
    },
  },
}
