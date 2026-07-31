return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
      inlay_hints = {
        enabled = false
      },
      servers = {
        bashls = {},
        glsl_analyzer = { enabled = false },
        pylsp = { enabled = false },
        snyk_ls = { enabled = false },
      },
    },
  },
}
