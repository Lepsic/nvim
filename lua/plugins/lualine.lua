
function GetRelativeFilePath()

  local file_path = vim.fn.expand('%:p')

  local relative_path = vim.fn.fnamemodify(file_path, ":~")

  return relative_path
end

-- Логируем начало настройки плагина lualine
local navic = require("nvim-navic")
return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons",
  "LuaDist/dkjson",
  },
  config = function()
    require("lualine").setup({
      options = {
        section_separators = "",
        component_separators = "",
      },
      sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff"},
        lualine_c = {'filename'},
        lualine_y = {'progress'},
        lualine_z = {
	 {
                "navic",
    
                -- Component specific options
                color_correction = nil, -- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
                                        -- Many colorschemes don't define same backgroud for nvim-navic as their lualine statusline backgroud.
                                        -- Setting it to "static" will perform a adjustment once when the component is being setup. This should
                                        --   be enough when the lualine section isn't changing colors based on the mode.
                                        -- Setting it to "dynamic" will keep updating the highlights according to the current modes colors for
                                        --   the current section.
    
                navic_opts = nil  -- lua table with same format as setup's option. All options except "lsp" options take effect when set here.
            }
        }
      },
    })
  end,
}
