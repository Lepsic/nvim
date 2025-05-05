
return {
  {
    "SmiteshP/nvim-navic",
    config = function()
      require'nvim-navic'.setup {
        icons = {
          Package = " ",
          Class   = "C",
          Method  = "M",
        },
        highlight = true,
        separator = " > ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        filter = function(item)
          return item.kind == "Package" or item.kind == "Class" or item.kind == "Method"
        end,
      }
    end,
  },
}
