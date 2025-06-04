return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = false,
  opts = {},
  keys = {
    {
      "<leader>rI",
      function()
        require("refactoring").refactor("Inline Function")
      end,
      mode = { "n", "v" },
      desc = "Inline Function",
    },
  },
}
