return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = "➤ ",
        layout_config = {
          horizontal = { preview_width = 0.6 },
        },
      },
    })

    -- Бинды для Telescope
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Поиск файлов" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Поиск текста" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Открытые буферы" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Поиск в документации" })
  end,
}
