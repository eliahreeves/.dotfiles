return { {
	"neovim/nvim-lspconfig",
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = { {

		'williamboman/mason-lspconfig.nvim',
		dependencies = { 'williamboman/mason.nvim' },
	}
	},
	config = function()
		-- require('lspconfig').clangd.setup {}
		require('mason-lspconfig').setup({
			ensure_installed = {
				'lua_ls',
				'marksman',
			},
		})
		require("mason-lspconfig").setup_handlers {
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server_name) -- default handler (optional)
				require("lspconfig")[server_name].setup {}
			end,
			-- Next, you can provide a dedicated handler for specific servers.
			-- For example, a handler override for the `rust_analyzer`:
			-- ["rust_analyzer"] = function()
			--	require("rust-tools").setup {}
			-- end
		}
	end
},
	{
		'williamboman/mason.nvim',
		opts = {
			ui = { border = 'single' },
			PATH = 'append',
		},
		config = function(_, opts) require('mason').setup(opts) end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy=false,
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "html" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				textobjects = {
					move = {
						enable = true,
						goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
						goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
						goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
						goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
					},
				},
			})
		end
	}
}
