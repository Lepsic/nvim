return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({
      options = {
        mode = "buffers", -- или "tabs"
        numbers = "ordinal", -- "none" | "ordinal" | "buffer_id"
        diagnostics = "nvim_lsp", -- "nvim_lsp" | "coc"
        separator_style = "slant", -- "slant" | "thick" | "thin" | "padding"
        -- Показывать иконки закрытия буферов
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
        -- Горячие клавиши работают даже если bufferline не активен
        always_show_bufferline = true,
      },
    })

    -- Установка горячих клавиш
    local map = vim.keymap.set

    -- Навигация между буферами
    map("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Следующий буфер" })
    map("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Предыдущий буфер" })

    -- Перемещение буферов
    map("n", "<leader>bn", "<Cmd>BufferLineMoveNext<CR>", { desc = "Переместить буфер вправо" })
    map("n", "<leader>bp", "<Cmd>BufferLineMovePrev<CR>", { desc = "Переместить буфер влево" })

    -- Закрытие буферов
    map("n", "<leader>bd", "<Cmd>BufferLinePickClose<CR>", { desc = "Закрыть выбранный буфер" })
    map("n", "<leader>bD", "<Cmd>BufferLineCloseRight<CR><Cmd>BufferLineCloseLeft<CR>", { desc = "Закрыть все, кроме текущего" })

    -- Быстрый выбор буфера по номеру (например, <leader>1 для первого буфера)
    for i = 1, 9 do
      map("n", "<leader>" .. i, function()
        require("bufferline").go_to_buffer(i)
      end, { desc = "Перейти к буферу " .. i })
    end

    -- Выбор буфера в интерактивном режиме
    map("n", "<leader>bb", "<Cmd>BufferLinePick<CR>", { desc = "Выбрать буфер" })
  end,
}
