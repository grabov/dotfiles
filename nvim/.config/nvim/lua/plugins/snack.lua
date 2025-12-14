return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      sections = {
        {
          section = "terminal",
          cmd = "chafa ~/.config/nvim/assets/banner.png --format symbols --symbols vhalf --size 60x12 --stretch; sleep .1",
          height = 15,
          padding = 1,
        },
        {
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
