return {
  "mfussenegger/nvim-dap-python",
  config = function()
    require("dap-python").setup("uv")
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
