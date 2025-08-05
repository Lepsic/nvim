
require("lazy").setup({
  { "neovim/nvim-lspconfig" },
})

local lspconfig = require("lspconfig")


lspconfig.nginx_language_server.setup({
  on_attach = function(client, bufnr)
    -- Общие LSP-бинды (как у pyright)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    -- Подключение navic
    require('nvim-navic').attach(client, bufnr)

    -- Включение автодополнения для LSP
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    client.server_capabilities = vim.tbl_deep_extend(
      "force",
      client.server_capabilities,
      capabilities
    )
  end,
  filetypes = { "nginx" },
  cmd = { "nginx-language-server", "--stdio" },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),  -- Важно для работы cmp!
})
