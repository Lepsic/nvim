local M = {}

local context_cache = {
  text = '',
  buf = nil,
  pos = nil,
  tick = nil
}

local function get_lsp_context()
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #clients == 0 then return '' end

  local params = vim.lsp.util.make_position_params()
  local context = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params, 1000)

  if not context or vim.tbl_isempty(context) then return '' end

  local symbols = context[1].result
  if not symbols or #symbols == 0 then return '' end

  table.sort(symbols, function(a, b)
    return a.range.start.line < b.range.start.line
  end)

  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local context_parts = {}

  for _, symbol in ipairs(symbols) do
    local start_line = symbol.range.start.line + 1
    local end_line = symbol.range["end"].line + 1

    if start_line <= current_line and current_line <= end_line then
      table.insert(context_parts, symbol.name)
    end
  end

  return table.concat(context_parts, ' > ')
end

local function get_treesitter_context()
  local ok, ts = pcall(require, 'nvim-treesitter')
  if not ok then return '' end

  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1] - 1
  local col = cursor[2]

  local queries = require('nvim-treesitter.query')
  local ft_to_query = {
    python = {
      '(class_definition name: (identifier) @name) @class',
      '(function_definition name: (identifier) @name) @function',
      '(for_statement) @loop',
      '(if_statement) @conditional',
    },
    lua = {
      '(function_declaration name: (identifier) @name) @function',
      '(if_statement) @conditional',
      '(for_statement) @loop',
    },
    javascript = {
      '(class_declaration name: (identifier) @name) @class',
      '(method_definition name: (property_identifier) @name) @method',
      '(function_declaration name: (identifier) @name) @function',
      '(for_statement) @loop',
      '(if_statement) @conditional',
    },
    typescript = {
      '(class_declaration name: (identifier) @name) @class',
      '(method_definition name: (property_identifier) @name) @method',
      '(function_declaration name: (identifier) @name) @function',
      '(for_statement) @loop',
      '(if_statement) @conditional',
    },
  }

  local filetype = vim.bo[bufnr].filetype
  local query_list = ft_to_query[filetype] or {}
  local context = {}

  for _, query in ipairs(query_list) do
    for _, match in ipairs(queries.get_capture_matches(bufnr, query, 'textobjects')) do
      local start_row, _, end_row, _ = match.node:range()
      if start_row <= row and row <= end_row then
        if match.capture == 'name' then
          table.insert(context, match.text)
        elseif not match.capture:find('name') then
          table.insert(context, match.capture:gsub('@', ''))
        end
      end
    end
  end

  return table.concat(context, ' > ')
end

function M.get_context()
  local buf = vim.api.nvim_get_current_buf()
  local pos = vim.api.nvim_win_get_cursor(0)
  local tick = vim.b[buf].changedtick

  if context_cache.buf == buf and 
     context_cache.pos[1] == pos[1] and 
     context_cache.pos[2] == pos[2] and 
     context_cache.tick == tick then
    return context_cache.text
  end

  context_cache.buf = buf
  context_cache.pos = pos
  context_cache.tick = tick

  local lsp_context = get_lsp_context()
  if lsp_context and #lsp_context > 0 then
    context_cache.text = lsp_context
    return lsp_context
  end

  local treesitter_context = get_treesitter_context()
  context_cache.text = treesitter_context
  return treesitter_context
end

return M
