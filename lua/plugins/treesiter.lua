return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Улучшенная конфигурация Treesitter
        ensure_installed = {
          "python",
          "lua",
          "bash",
          "javascript",
          "typescript",
          "html",
          "css",
          "json"
        }, -- Расширенный список языков
        sync_install = false, -- Не устанавливать синхронно (может тормозить)
        auto_install = true, -- Автоустановка парсеров для новых файлов
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          disable = {}, -- Языки, где подсветку нужно отключить
          custom_captures = {
            ["keyword.python"] = "Keyword",
            ["class.python"] = "Type",
            ["function.python"] = "Function",
          },
        },
        indent = {
          enable = true,
          disable = {"yaml"} -- Языки, где автоотступы работают плохо
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })

      -- Улучшенные настройки цветов
      vim.api.nvim_set_hl(0, "TSKeyword", { ctermfg = 202, bold = true })
      vim.api.nvim_set_hl(0, "TSFunction", { ctermfg = 82, italic = true })
      vim.api.nvim_set_hl(0, "TSClass", { ctermfg = 220, bold = true })
      vim.api.nvim_set_hl(0, "TSVariable", { ctermfg = 51 })
      vim.api.nvim_set_hl(0, "TSVariableBuiltin", { ctermfg = 198 })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost", -- Загружать только после открытия файла
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = { "Function", "Label" },
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "NvimTree",
          "Trouble",
          "lazy",
          "mason",
          "alpha"
        },
        buftypes = {
          "terminal",
          "nofile",
          "quickfix",
          "prompt"
        }
      },
    },
    config = function(_, opts)
      -- Настройка цветов для indent-blankline
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3b4252", nocombine = true })
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#81a1c1", nocombine = true })
      
      require("ibl").setup(opts)
    end
  }
}
