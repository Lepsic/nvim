
return {
  {
    "tpope/vim-fugitive", -- Основной плагин для работы с Git
    config = function()
      -- Настройки для vim-fugitive
      vim.cmd([[
        " Настройки для vim-fugitive
        " Пример: автоматическое обновление статуса Git
        autocmd BufEnter *.git/! :Git
      ]])
    end,
  },
  {
    "airblade/vim-gitgutter", -- Плагин для подсветки изменений
    config = function()
      -- Настройки для vim-gitgutter
      vim.g.gitgutter_signs = 1
      vim.g.gitgutter_sign_added = '✚'
      vim.g.gitgutter_sign_modified = '✹'
      vim.g.gitgutter_sign_removed = '✖'
    end,
  },
  {
    "f-person/git-blame.nvim", -- Плагин для отображения Git-блейма
    config = function()
      -- Настройки для git-blame.nvim
      require('gitblame').setup {
        enabled = true,
      }
    end,
  },
}
