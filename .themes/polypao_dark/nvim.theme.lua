return {
	{
		"echasnovski/mini.base16",
		lazy = false,
		priority = 1000,
		config = function()
			require("mini.base16").setup({
				palette = {
					base00 = "#292a2d",
					base01 = "#313131",
					base02 = "#4e4e4e",
					base03 = "#5e5e5e",

					base04 = "#FFFFFF",
					base05 = "#F3F3F3",
					base06 = "#D8D8D8",
					base07 = "#b9b9b9",
					--- NOTE double check
					base08 = "#ACE5B3",
					base09 = "#c6c5fc",
					base0B = "#9E96Ed",
					base0C = "#85DDD9",
					base0D = "#dB8DB3",
					base0E = "#F4A792",
					base0F = "#48C1B8",
					base0A = "#efafD1",
				},
			})
		end,
	},
}
