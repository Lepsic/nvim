function GetRelativeFilePath()
  local file_path = vim.fn.expand('%:p')
  local relative_path = vim.fn.fnamemodify(file_path, ":~")
  return relative_path
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "LuaDist/dkjson",
    "SmiteshP/nvim-navic",  -- Рекомендую использовать официальный репозиторий navic
  },
  config = function()
    -- Настройка шрифтов (требует поддержки терминалом и Nerd Font)
    vim.g.neovide_font = "0xProto Nerd Font Mono:h12"		
    
    local navic = require("nvim-navic")
    require("lualine").setup({
      options = {
        theme = 'auto',  -- Автоматически подстраивается под colorscheme
        component_separators = { left = '│', right = '│' },  -- Тонкие разделители
        section_separators = { left = '', right = '' },  -- Пустые разделители секций
        disabled_filetypes = {  -- Отключение для определенных типов файлов
          'NvimTree',
          'packer',
          'alpha',
          'dashboard'
        },
        globalstatus = true,  -- Глобальный статусбар для Neovim 0.7+
      },
      sections = {
        lualine_a = {
          { 'mode', icon = '', padding = { left = 1, right = 1 } },  -- Иконка режима
        },
        lualine_b = {
          { 'branch', icon = '', padding = { left = 1, right = 1 } },  -- Иконка ветки
          { 'diff', padding = { left = 1, right = 1 }, symbols = { added = ' ', modified = ' ', removed = ' ' } },
          { 'diagnostics', padding = { left = 1, right = 1 } },
        },
        lualine_x = {
          { 'encoding', padding = { left = 1, right = 1 } },
          { 'fileformat', padding = { left = 1, right = 1 }, symbols = { unix = '', dos = '', mac = '' } },
          { 'filetype', padding = { left = 1, right = 1 } },
        },
        lualine_y = {
          { 'progress', padding = { left = 1, right = 1 } },
        },
        lualine_z = {
          { 'location', padding = { left = 1, right = 1 } },
        }
      },
      inactive_sections = {
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
      },
      extensions = { 'fugitive', 'nvim-tree', 'toggleterm' }  -- Поддержка расширений
    })
  end,
}
