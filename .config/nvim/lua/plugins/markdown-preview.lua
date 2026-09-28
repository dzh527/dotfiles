return {
  {
    "selimacerbas/markdown-preview.nvim",
    dependencies = { "selimacerbas/live-server.nvim" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewRefresh" },
    keys = {
      { "<leader>ms", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
      { "<leader>mS", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Markdown Preview" },
      { "<leader>mr", "<cmd>MarkdownPreviewRefresh<cr>", desc = "Refresh Markdown Preview" },
    },
    main = "markdown_preview",
    opts = {},
  },
}
