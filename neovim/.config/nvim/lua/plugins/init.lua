local ok, packer = pcall(require, "packer")

local plugins = function(use)
	-- Packer needs to manage itself of else there are errors
	use({ "wbthomason/packer.nvim" })

	-- A custom status bar
	use({
		"hoob3rt/lualine.nvim",
		as = "lualine",
		config = function()
			require("plugins.config.lualine")
		end,
	})

	-- This is to improve loading times with some optimizations
	use({ "lewis6991/impatient.nvim" })
	-- This one is just a dependancy for a lot of packages
	use({ "nvim-lua/plenary.nvim" })
	-- Dependency for a few plugins
	use({
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("plugins.config.devicons")
		end,
		event = "BufWinEnter",
	})

	-- Fuzzy finder NOTE cmd specifies a command that must be run in order to load the plugin
	use({
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			require("plugins.config.telescope")
		end,
	})
	-- Plugin for telescope that allows previewing media files
	use({ "nvim-telescope/telescope-media-files.nvim", event = "BufWinEnter" })
	-- Buffers as tabs
	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("plugins.config.bufferline")
		end,
		after = "nvim-web-devicons",
	})
	-- Navigation tree
	use({
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require("plugins.config.nvimtree")
		end,
	})
	-- Automatically create pairs of brackets, html open close etc.
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("plugins.config.autopairs")
		end,
		event = "BufWinEnter",
	})
	-- Auto close tag
	use({ "windwp/nvim-ts-autotag", event = "BufWinEnter" })
	-- Comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("plugins.config.comment")
		end,
		event = "BufWinEnter",
	})
	use({
		"folke/todo-comments.nvim",
		config = function()
			require("plugins.config.todocomments")
		end,
		event = "BufWinEnter",
	})
	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("plugins.config.gitsigns")
		end,
		event = "BufWinEnter",
	})
	-- Live code server
	use({ "metakirby5/codi.vim", even = "BufWinEnter" })

	-- Make the current context sticky
	use({
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("plugins.config.treesitter-context")
		end,
	})

	-- Syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		module = "nvim-treesitter",
		event = "BufWinEnter",
		run = ":TSUpdate",
		config = function()
			require("plugins.config.treesitter")
		end,
	})

	-- Colorizer (adding inline colors for hex)
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("plugins.config.nvim-colorizer")
		end,
	})

	use({
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("plugins.config.themes.rose-pine")
		end,
		after = "lualine",
	})

	-- LSP
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			{ "jose-elias-alvarez/null-ls.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
	})
end

-- Set the options for packer
local init_options = {
	auto_clean = true,
	compile_on_sync = true,
	git = { clone_timeout = 6000 },
	display = {
		working_sym = "ﲊ",
		error_sym = "✗ ",
		done_sym = " ",
		removed_sym = " ",
		moved_sym = "",
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
}

if ok then
	-- This is so that lazy loaded plugins can be seen
	vim.cmd("packadd packer.nvim")

	packer.init(init_options)
	packer.startup(plugins)
end
