return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = {
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics", {
				"buffers",
				buffers_color = {
					active = { gui = "bold", fg = "#B4D4CF" },
				},
			} },
			lualine_c = {},
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		tabline = {},
	},
}
