return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
      servers = {
        snyk_ls = { enabled = false },
      },
    },
  },
}
