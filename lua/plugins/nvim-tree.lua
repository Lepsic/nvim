return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Иконки для дерева файлов
    config = function()
      -- Настройка плагина nvim-tree
      require("nvim-tree").setup({
        view = {
          width = 30, -- Ширина панели дерева
          side = "left", -- Расположение дерева: слева
        },
        renderer = {
          highlight_git = true, -- Подсветка статуса git
          icons = {
            show = {
              git = true, -- Отображение значков git
              folder = true,
              file = true,
            },
          },
        },
        filters = {
          dotfiles = false, -- Показывать скрытые файлы
        },
      })

      -- Клавиша для открытия/закрытия дерева файлов
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Открыть/закрыть дерево файлов" })
    end,
  }
