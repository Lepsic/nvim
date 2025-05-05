return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,                   
      open_mapping = [[<c-\>]],   
      direction = "horizontal",        -- "horizontal", "vertical", "tab", "float"
      close_on_exit = true,       -- Закрывать при выходе из процесса
      shell = vim.o.shell,        -- Использовать системный shell (bash/zsh/fish)
      float_opts = {
        border = "curved",        -- "single", "double", "shadow", "curved"
        winblend = 10,            -- Прозрачность (0-100)
      },

      -- Кастомные команды
      highlights = {
        NormalFloat = { link = "Normal" },  -- Стиль плавающего окна
      },
    })

    -- Кастомные терминалы с горячими клавишами
    local Terminal = require("toggleterm.terminal").Terminal

    -- 1. Базовый терминал (Python в примере)
    local python = Terminal:new({
      cmd = "python",
      hidden = true,
      direction = "float",
      on_open = function(term)
        vim.cmd("startinsert!")  -- Автовход в insert-режим
      end,
    })

    -- 2. Git терминал
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = { border = "double" },
    })

    -- Бинды
    vim.keymap.set("n", "<leader>tp", function() python:toggle() end, { desc = "Toggle Python" })
    vim.keymap.set("n", "<leader>tg", function() lazygit:toggle() end, { desc = "Toggle Lazygit" })
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })  -- Выход из терминала в нормальный режим
  end
}
