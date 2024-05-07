return {
	{
		"echasnovski/mini.base16",
		lazy = false,
		priority = 1000,
		config = function()
			require("mini.base16").setup({
				palette = {
					base00 = "#1f2328",
					base01 = "#3e3e3e",
					base02 = "#4e4e4e",
					base03 = "#5e5e5e",
					base04 = "#FFFFFF",
					base05 = "#F3F3F3",
					base06 = "#D8D8D8",
					base07 = "#b9b9b9",
					--- NOTE double check
					base08 = "#639c08",
					base09 = "#744527",
					base0A = "#B26A3E",
					base0B = "#D9006A",
					base0C = "#00AF8D",
					base0D = "#A8195F",
					base0F = "#429484",
					base0E = "#FF6400",
				},
			})
		end,
	},
}
