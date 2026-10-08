return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      -- pyright spams "✔ pyright" progress on every keystroke
      progress = { enabled = false },
    },
  },
}
