return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate", -- Автоматическое обновление парсеров
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "python", "lua" }, -- Добавляем языки
      highlight = {
        enable = true, -- Включить подсветку
        additional_vim_regex_highlighting = false, -- Отключить устаревшую подсветку
      },
      indent = {
        enable = true, -- Умное выравнивание
      },
    })

    -- Настройка цветов вручную через `vim.api.nvim_set_hl`
    vim.api.nvim_set_hl(0, "TSKeyword", { fg = "#FF5733" }) -- Цвет для ключевых слов
    vim.api.nvim_set_hl(0, "TSFunction", { fg = "#33FF57" }) -- Цвет для функций
    vim.api.nvim_set_hl(0, "TSClass", { fg = "#FFC300" }) -- Цвет для классов
    vim.api.nvim_set_hl(0, "TSVariable", { fg = "#00C9FF" }) -- Цвет для переменных
  end,
}

