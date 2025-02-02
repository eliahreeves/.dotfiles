return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
      require("flutter-tools").setup({
        fvm = is_windows,
      })
    end,
  },
}

