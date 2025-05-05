local function create_file_in_current_dir()
  local dir = vim.fn.expand("%:h") -- Получить директорию текущего файла
  local new_file = vim.fn.input("Enter new file name: ", dir .. "/", "file")
  if new_file ~= "" then
    vim.cmd("e " .. new_file) -- Открыть новый файл
  end
end

vim.api.nvim_create_user_command("CreateFile", create_file_in_current_dir, {})

