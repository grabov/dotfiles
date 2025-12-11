return {
  {
    "nvim-treesitter/nvim-treesitter",

    opts = {
      auto_install = true,
      ensure_installed = {
        "bash",
        "css",
        "csv",
        "dockerfile",
        "editorconfig",
        "hcl",
        "helm",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "nginx",
        "python",
        "regex",
        "sql",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      -- TODO: Hotkeys doesn't work
      -- incremental_selection = {
      --   enable = true,
      --   keymaps = {
      --     init_selection = "gnn", -- set to `false` to disable one of the mappings
      --     node_incremental = "grn",
      --     scope_incremental = "grc",
      --     node_decremental = "grm",
      --   },
      -- },
      -- textobjects = {
      --   move = {
      --     enable = true,
      --     goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
      --     goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
      --     goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
      --     goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
      --   },
      -- },
    },
  },
}
