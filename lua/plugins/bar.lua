return {
  "romgrk/barbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Иконки
  config = function()
    require("bufferline").setup({
      -- Настройки, если нужны
    })
  end,
}
