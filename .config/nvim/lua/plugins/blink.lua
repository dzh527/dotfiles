return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<Tab>"] = {
          "select_and_accept",
          "snippet_forward",
          "fallback",
        },
      },
    },
  },
}
