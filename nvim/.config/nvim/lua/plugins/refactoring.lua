return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = false,
  opts = {},
  keys = {
    -- vim.keymap.set("x", "<leader>re", ":Refactor extract ")
    -- vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")
    --
    -- vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
    --
    -- vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")
    -- vim.keymap.set( "n", "<leader>rI", ":Refactor inline_func")
    --
    -- vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
    -- vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")
    -- {
    {
      "<leader>ri",
      ":Refactor inline_var<CR>",
      mode = { "n", "x" },
      desc = "Inline Variable",
    },
    {
      "<leader>rI",
      ":Refactor inline_func<CR>",
      mode = { "n" },
      desc = "Inline Function",
    },
    {
      "<leader>rv",
      ":Refactor extract_var",
      mode = { "x" },
      desc = "Extract Variable",
    },
    {
      "<leader>rb",
      ":Refactor extract_block<CR>",
      mode = { "n" },
      desc = "Extract Block",
    },
    {
      "<leader>rf",
      ":Refactor extract_block_to_file<CR>",
      mode = { "n" },
      desc = "Extract Block to file",
    },

    -- {
    --   "<leader>ri",
    --   function()
    --     require("refactoring").refactor("Inline Variable")
    --   end,
    --   mode = { "n", "v" },
    --   desc = "Inline Variable",
    -- },
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
