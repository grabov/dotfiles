return {
  "mfussenegger/nvim-dap-python",
  config = function()
    require("dap-python").setup() -- "/home/viktor/.asdf/shims/debugpy")
    require("dap").configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "My custom launch configuration",
        justMyCode = false,
        program = "${file}",
      },
    }
  end,
}
