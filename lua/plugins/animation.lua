
return {
  "echasnovski/mini.animate",
  config = function()
    local animate = require("mini.animate")

    animate.setup({
      cursor = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 25 }),
      },
      scroll = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 25 }),
        subscroll = animate.gen_subscroll.equal({ steps = 60 }),
      },
      resize = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 25 }),
        subresize = animate.gen_subresize.equal(),
      },
      open = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 25 }),
        winconfig = animate.gen_winconfig.static({ steps = 25 }),
        winblend = animate.gen_winblend.linear({ start = 80, end_ = 100 }),
      },
      close = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 25 }),
        winconfig = animate.gen_winconfig.static({ steps = 25 }),
        winblend = animate.gen_winblend.linear({ start = 80, end_ = 100 }),
      },
    })
  end,
}
