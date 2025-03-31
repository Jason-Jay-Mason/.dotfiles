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
    lazy = true,
    config = function()
      require("plugins.config.devicons")
    end,
  },
  -- Fuzzy finder NOTE cmd specifies a command that must be run in order to load the plugin
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v4.x',
    config = function()
      require("plugins.config.lsp")
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason.nvim",           -- Optional
      "neovim/nvim-lspconfig",             -- Required
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
    config = function()
      require("plugins.config.neogit")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      "echasnovski/mini.pick",         -- optional
    },
  },
  {
    "pcolladosoto/tinygo.nvim",
    lazy = false,
    config = function() require("tinygo").setup() end
  },
  -- cursor like environment ai assistant
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    config = function()
      require("plugins.config.avante")
    end,
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick",         -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua",              -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",        -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }

}
