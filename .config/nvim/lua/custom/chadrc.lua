local M = {}
M.ui = {
  changed_themes = {
    gruvbox_light = {
      base_16 = {
        base00 = "#fbf1c7",
        base01 = "#ebdbb2",
        base02 = "#d5c4a1",
        base03 = "#bdae93",
        base04 = "#665c54",
        base05 = "#504945",
        base06 = "#3c3836",
        base07 = "#282828",
        base08 = "#9d0006",
        base09 = "#af3a03",
        base0A = "#b57614",
        base0B = "#79740e",
        base0C = "#427b58",
        base0D = "#076678",
        base0E = "#8f3f71",
        base0F = "#d65d0e",
      },
    },
    gruvbox = {
      base_16 = {
        base00 = "#282828",
        base01 = "#3c3836",
        base02 = "#504945",
        base03 = "#665c54",
        base04 = "#bdae93",
        base05 = "#d5c4a1",
        base06 = "#ebdbb2",
        base07 = "#fbf1c7",
        base08 = "#fb4934",
        base09 = "#fe8019",
        base0A = "#fabd2f",
        base0B = "#b8bb26",
        base0C = "#8ec07c",
        base0D = "#83a598",
        base0E = "#d3869b",
        base0F = "#d65d0e",
      },
    },
    github_light = {
      base_16 = {
        base00 = "#ffffff",
        -- The following override for polypao_light
        base08 = "#C05589",
        base09 = "#48c1b8",
        base0A = "#FF6400",
        base0B = "#429484",
        base0C = "#933362",
        base0D = "#00AF8D",
        base0E = "#D9006A",
        base0F = "#744527",
      },
      base_30 = {
        -- The following override for polypao
        folder_bg = "#919191",
        statusline_bg = "#ffffff",
        darker_black = "#ffffff",
        one_bg2 = "#e0e0e0", -- StatusBar (filename)
        nord_blue = "#48c1b8",
        blue = "#48c1b8",
        red = "#D9006a", -- StatusBar (file percentage)
        green = "#00AF8D",
        vibrant_green = "#00AF8D",
        orange = "#FF6400",
        yellow = "#E89867",
        sun = "#f4a792",
        baby_pink = "#db8db3",
        pink = "#db8db3",
        purple = "#9e96ed",
        dark_purple = "#9e96ed",
        teal = "#48c1b8",
        cyan = "#48c1b8",
      },
    },
    github_dark = {
      base_16 = {
        base00 = "#292a2d",
        -- The following override for polypao
        base08 = "#DB8DB3",
        base09 = "#ACE5B3",
        base0A = "#85DDD9",
        base0B = "#9E96ED",
        base0C = "#F4A792",
        base0D = "#48C1B8",
        base0E = "#EFAFD1",
        base0F = "#C6C5FC",
      },
      base_30 = {
        -- The following override for polypao
        folder_bg = "#F4A792",
        statusline_bg = "#292a2d",
        darker_black = "#292a2d",
        one_bg2 = "#494949", -- StatusBar (filename)
        nord_blue = "#85ddd9",
        blue = "#afefea",
        red = "#DB8DB3", -- StatusBar (username)
        green = "#A9D65F", -- StatusBar (file percentage)
        vibrant_green = "#ace5b3",
        line = "#494949", -- for lines like vertsplit
        orange = "#f4a792",
        yellow = "#f4bcae",
        sun = "#f4a792",
        baby_pink = "#efafd1",
        pink = "#db8db3",
        purple = "#c6c5fc",
        dark_purple = "#9e96ed",
        teal = "#75e0d5",
        cyan = "#48c1b8",
      },
    },
  },
  theme = 'github_light',
}

M.plugins = "custom.plugins"

return M
