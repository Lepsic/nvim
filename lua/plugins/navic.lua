return {
  {
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      -- Добавляем кастомные иконки для всех элементов
      local icons = {
        File          = " ",
        Module        = " ",
        Namespace     = " ",
        Package       = " ",
        Class         = " ",
        Method        = " ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = "練",
        Interface     = "練",
        Function      = " ",
        Variable      = " ",
        Constant      = " ",
        String        = " ",
        Number        = " ",
        Boolean       = "◩ ",
        Array         = " ",
        Object        = " ",
        Key           = " ",
        Null          = "ﳠ ",
        EnumMember    = " ",
        Struct        = " ",
        Event         = " ",
        Operator      = " ",
        TypeParameter = " ",
        -- Добавляем кастомные типы для условий и циклов
        IfStatement   = " ",
        ElseClause    = " ",
        ForStatement  = " ",
        WhileStatement= " ",
        Loop          = " ",
        Condition     = " ",
      }

      require('nvim-navic').setup({
        icons = icons,
        highlight = true,
        separator = "  ",
        depth_limit = 5,
        depth_limit_indicator = "..",
        lsp = {
          auto_attach = true,
          preference = nil,
        },
      })

      -- Расширяем обработку символов для поддержки условий и циклов
      local navic = require("nvim-navic")
      local original_get_location = navic.get_location

      -- Переопределяем функцию get_location
      function navic.get_location()
        local location = original_get_location()
        if not location or location == "" then return location end

        -- Получаем текущий контекст из treesitter для более детальной информации
        local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
        if ok then
          local node = ts_utils.get_node_at_cursor()
          while node do
            local node_type = node:type()
            
            -- Добавляем условия и циклы в контекст
            if node_type:match("if_statement") then
              location = location .. "  " .. icons.IfStatement .. "if"
            elseif node_type:match("else_clause") then
              location = location .. "  " .. icons.ElseClause .. "else"
            elseif node_type:match("for_statement") then
              location = location .. "  " .. icons.ForStatement .. "for"
            elseif node_type:match("while_statement") then
              location = location .. "  " .. icons.WhileStatement .. "while"
            end

            node = node:parent()
          end
        end

        return location
      end
    end
  }
}
