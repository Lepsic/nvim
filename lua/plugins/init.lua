return require("lazy").setup({
  -- Плагин для LSP
  {
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",

    config = function()
      require("lspconfig") -- Загружаем LSP конфигурацию
    end,
  },
  -- Автоматическая установка LSP серверов
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        install_root_dir = vim.fn.stdpath("data") .. "/lsp_servers", -- Каталог для серверов
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  -- vim.g.tokyonight_style = "night"  -- Включаем ночной стиль

  -- Для удобного управления плагинами
  "nvim-lua/plenary.nvim",
  { import = "plugins.telescope" },
  { import = "plugins.lualine" },
  { import = "plugins.nvim-tree" },
  { import = "plugins.bar"},
  { import = "plugins.git"},
  { import = "plugins.colorscheme" },
  { import = "plugins.treesiter" },
  { import = "plugins.cmp" },
  { import = "plugins.toggleterm" },
  --{ import = "plugins.navic" },
  { import = "plugins.animation" },
})


