return {
  {
    "hrsh7th/nvim-cmp", -- Основной плагин
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- Источник LSP
      "hrsh7th/cmp-buffer", -- Источник буфера
      "hrsh7th/cmp-path", -- Источник файловой системы
      "hrsh7th/vim-vsnip", -- Сниппеты
    },
    config = function()
      local cmp = require("cmp") -- Явно загружаем cmp
      local delay_timer = vim.loop.new_timer() -- Создаем таймер для задержки
      local autocomplete_enabled = false -- Флаг для включения/выключения автокомплита

      -- ФунPя для запуска автокомплита с задержкой
      local function setup_autocomplete_with_delay()
        vim.api.nvim_create_autocmd("TextChangedI", {
          callback = function()
            if not autocomplete_enabled then
              return
            end

            local current_line = vim.api.nvim_get_current_line()
            if current_line == "" then
              return -- Если строка пустая, не запускаем автокомплит
            end

            delay_timer:stop() -- Останавливаем текущий таймер, если ввод продолжается
            delay_timer:start(800, 0, vim.schedule_wrap(function()
              if cmp.visible() then
                return -- Если меню уже открыто, ничего не делаем
              end
              cmp.complete() -- Показываем меню автокомплита
            end))
          end,
        })
      end

      -- Общие настройки для nvim-cmp
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' }, -- Источник LSP
          { name = 'buffer' }, -- Источник из буфера
          { name = 'path' }, -- Источник файловой системы
        }),

        mapping = cmp.mapping.preset.insert({
          ['<C-F>'] = function()
            autocomplete_enabled = true
            setup_autocomplete_with_delay()
          end,
          ['<C-X>'] = function()
            autocomplete_enabled = false
            delay_timer:stop()
            cmp.abort()
          end,
          ['<C-A>'] = cmp.mapping.confirm({ select = true }), -- Подтвердить выбор
          ['<C-N>'] = cmp.mapping.select_next_item(), -- Перемещение вперёд
          ['<C-P>'] = cmp.mapping.select_prev_item(), -- Перемещение назад
        }),
	

        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- Настройка сниппетов (vsnip)
          end,
        },

        completion = {
          autocomplete = false, -- Отключаем автопоявление по умолчанию
          max_view_entries  = 4,
        },

        formatting = {
          format = function(entry, vim_item)
            -- Показываем источник в меню
            if entry.source.name == "nvim_lsp" and entry.completion_item.additionalTextEdits then
              -- Помечаем автоимпорт
              vim_item.kind = " [Import]"
            end
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
          max_width = 50, -- Максимальная ширина окна автокомплита
          max_height = 3, -- Максимальная высота окна автокомплита
        },
      })

      -- Настройки для Python
      cmp.setup.filetype('python', {
        sources = cmp.config.sources({
          { name = 'nvim_lsp', keyword_length = 2 },
          { name = 'buffer' },
          { name = 'path' },
        }),

        completion = {
          autocomplete = false, -- Выключаем автокомплит для Python
        },
      })

      -- Автоимпорты
      local lspconfig = require('lspconfig')
      lspconfig.pyright.setup({
        on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local opts = { noremap = true, silent = true }

          -- Команда для выполнения автоимпорта через LSP
          buf_set_keymap('n', '<leader>ai', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        end,
        settings = {
          python = {
            analysis = {
              autoImportCompletions = true, -- Включаем автоимпорты
            },
          },
        },
      })

      -- Настройка цветов для окна автокомплита
      vim.cmd([[
        highlight CmpItemAbbr ctermfg=White ctermbg=Black
        highlight CmpItemKind ctermfg=White ctermbg=Black
        highlight CmpItemMenu ctermfg=White ctermbg=Black
        highlight CmpItemAbbrDeprecated ctermfg=White ctermbg=Black
        highlight CmpItemAbbrMatch ctermfg=White ctermbg=Black
        highlight CmpItemAbbrMatchFuzzy ctermfg=White ctermbg=Black
        highlight CmpItemKindDefault ctermfg=White ctermbg=Black
        highlight CmpItemKindKeyword ctermfg=White ctermbg=Black
        highlight CmpItemKindVariable ctermfg=White ctermbg=Black
        highlight CmpItemKindConstant ctermfg=White ctermbg=Black
        highlight CmpItemKindReference ctermfg=White ctermbg=Black
        highlight CmpItemKindValue ctermfg=White ctermbg=Black
        highlight CmpItemKindFunction ctermfg=White ctermbg=Black
        highlight CmpItemKindMethod ctermfg=White ctermbg=Black
        highlight CmpItemKindConstructor ctermfg=White ctermbg=Black
        highlight CmpItemKindField ctermfg=White ctermbg=Black
        highlight CmpItemKindProperty ctermfg=White ctermbg=Black
        highlight CmpItemKindEnum ctermfg=White ctermbg=Black
        highlight CmpItemKindInterface ctermfg=White ctermbg=Black
        highlight CmpItemKindColor ctermfg=White ctermbg=Black
        highlight CmpItemKindFile ctermfg=White ctermbg=Black
        highlight CmpItemKindModule ctermfg=White ctermbg=Black
        highlight CmpItemKindClass ctermfg=White ctermbg=Black
        highlight CmpItemKindOperator ctermfg=White ctermbg=Black
        highlight CmpItemKindTypeParameter ctermfg=White ctermbg=Black
        highlight CmpItemKindSnippet ctermfg=White ctermbg=Black
        highlight CmpItemKindText ctermfg=White ctermbg=Black
        highlight CmpItemKindUnit ctermfg=White ctermbg=Black
        highlight CmpItemKindStruct ctermfg=White ctermbg=Black
        highlight CmpItemKindEvent ctermfg=White ctermbg=Black
      ]])
    end,
  },
}

