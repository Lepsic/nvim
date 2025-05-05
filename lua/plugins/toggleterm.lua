return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,                   
      open_mapping = [[<c-\>]],   
      direction = "horizontal",        -- "horizontal", "vertical", "tab", "float"
      close_on_exit = true,       -- ��������� ��� ������ �� ��������
      shell = vim.o.shell,        -- ������������ ��������� shell (bash/zsh/fish)
      float_opts = {
        border = "curved",        -- "single", "double", "shadow", "curved"
        winblend = 10,            -- ������������ (0-100)
      },

      -- ��������� �������
      highlights = {
        NormalFloat = { link = "Normal" },  -- ����� ���������� ����
      },
    })

    -- ��������� ��������� � �������� ���������
    local Terminal = require("toggleterm.terminal").Terminal

    -- 1. ������� �������� (Python � �������)
    local python = Terminal:new({
      cmd = "python",
      hidden = true,
      direction = "float",
      on_open = function(term)
        vim.cmd("startinsert!")  -- �������� � insert-�����
      end,
    })

    -- 2. Git ��������
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = { border = "double" },
    })

    -- �����
    vim.keymap.set("n", "<leader>tp", function() python:toggle() end, { desc = "Toggle Python" })
    vim.keymap.set("n", "<leader>tg", function() lazygit:toggle() end, { desc = "Toggle Lazygit" })
    vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })  -- ����� �� ��������� � ���������� �����
  end
}
