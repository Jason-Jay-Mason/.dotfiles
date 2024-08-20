local colors = require("settings.colors")
local themes = {
  ["rose-pine"] = {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      require("plugins.config.rose-pine")
    end,
  }
}

return {
  themes[colors.theme],
  -- Needed for a lot of plugins
  "nvim-lua/plenary.nvim",
  -- Needed for a lot of plugins
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugins.config.devicons")
    end,
  },
  -- Fuzzy finder NOTE cmd specifies a command that must be run in order to load the plugin
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require("plugins.config.telescope")
    end,
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-telescope/telescope-media-files.nvim"
    }
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
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v4.x',
    config = function()
      require("plugins.config.lsp-zero")
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",             -- Required
      "williamboman/mason.nvim",           -- Optional
      "williamboman/mason-lspconfig.nvim", -- Optional
      -- Formatting replacing null ls
      "nvimdev/guard.nvim",
      "nvimdev/guard-collection",
      -- Autocompletion
      "hrsh7th/nvim-cmp",     -- Required
      "hrsh7th/cmp-nvim-lsp", -- Required
      "hrsh7th/cmp-path",     -- Optional
      "hrsh7th/cmp-nvim-lua", -- Optional
      -- Snippets
      "L3MON4D3/LuaSnip"      -- Required
    }
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
    config = function()
      require("plugins.config.gitsigns")
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugins.config.nvim-colorizer")
    end,
  }
}
