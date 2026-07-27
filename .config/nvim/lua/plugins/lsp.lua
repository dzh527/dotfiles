return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        virtual_text = false,
      },
      servers = {
        glsl_analyzer = { enabled = false },
        pylsp = { enabled = false },
        snyk_ls = { enabled = false },
      },
    },
  },
}
