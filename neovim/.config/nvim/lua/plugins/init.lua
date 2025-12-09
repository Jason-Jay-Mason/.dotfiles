local colors = require("settings.colors")
local themes = {
	["rose-pine"] = {
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("plugins.config.rose-pine")
		end,
	},
}

return {
	themes[colors.theme],
	-- Needed for a lot of plugins
	"nvim-lua/plenary.nvim",
	-- Needed for a lot of plugins
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = function()
			require("plugins.config.devicons")
		end,
	},
	-- Fuzzy finder NOTE cmd specifies a command that must be run in order to load the plugin
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		lazy = true,
		config = function()
			require("plugins.config.telescope")
		end,
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-telescope/telescope-media-files.nvim",
		},
	},

	-- Buffers as tabs
	{

		"akinsho/bufferline.nvim",
		config = function()
			require("plugins.config.bufferline")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		lazy = true,
		config = function()
			require("plugins.config.nvimtree")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.config.treesitter")
		end,
	},
	{
		"hoob3rt/lualine.nvim",
		name = "lualine",
		config = function()
			require("plugins.config.lualine")
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.config.autopairs")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("plugins.config.nvim-ts-autotag")
		end,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			require("plugins.config.todocomments")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		config = function()
			require("plugins.config.gitsigns")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		lazy = true,
		config = function()
			require("plugins.config.nvim-colorizer")
		end,
	},
	-- git environment for nvim
	{
		"NeogitOrg/neogit",
		lazy = true,
		config = function()
			require("plugins.config.neogit")
		end,
		dependencies = {
			"sindrets/diffview.nvim", -- optional - Diff integration
			-- Only one of these is needed.
			"ibhagwan/fzf-lua", -- optional
			"nvim-mini/mini.pick", -- optional
			"folke/snacks.nvim", -- optional
		},
	},
	--lsp
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("plugins.config.lsp")
		end,
		dependencies = {
			--mason
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			--cmp
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/nvim-cmp",
			--guard
			"nvimdev/guard-collection",
			"nvimdev/guard.nvim",
		},
	},
}
