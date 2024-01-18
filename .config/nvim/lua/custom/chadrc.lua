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
        base09 = "#A9D65F",
        base0A = "#FF6400",
        base0B = "#429484",
        base0C = "#933362",
        base0D = "#744527",
        base0E = "#D9006A",
        base0F = "#00AF8D",
      },
    },
    github_dark = {
      base_30 = {
        folder_bg = "#F4A792",
      },
      base_16 = {
        base00 = "#1f2328",
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
    },
  },
  theme = 'github_dark',
}

M.plugins = "custom.plugins"

return M
