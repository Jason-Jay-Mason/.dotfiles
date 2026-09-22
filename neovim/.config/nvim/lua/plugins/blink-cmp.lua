-- LSP capabilities for all servers (replaces cmp-nvim-lsp from the old setup).
-- pcall-guarded: on the very first startup blink.cmp isn't downloaded yet, and
-- a failed require here would break lazy's spec collection for this file.
local ok, blink = pcall(require, "blink.cmp")
if ok then
  vim.lsp.config("*", {
    capabilities = blink.get_lsp_capabilities(),
  })
end

return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        optional = true, -- only installed if a compat source is ever added
        opts = {},
        version = "*",
      },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = {
        preset = "default",
      },

      appearance = {
        use_nvim_cmp_as_default = false, -- rose-pine ships native blink.cmp highlights
        nerd_font_variant = "mono",
      },

      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        list = {
          selection = { preselect = true }, -- old cmp: preselect = "item"
        },
        menu = {
          border = "rounded", -- old cmp: bordered completion window
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = true, -- set false to match the old cmp config (no ghost text)
        },
      },

      sources = {
        compat = {},
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          buffer = { min_keyword_length = 3 }, -- old cmp: keyword_length = 3
        },
      },

      cmdline = {
        enabled = true,
        keymap = {
          preset = "cmdline",
          ["<Right>"] = false,
          ["<Left>"] = false,
        },
        completion = {
          list = { selection = { preselect = false } },
          menu = {
            auto_show = function(ctx)
              return vim.fn.getcmdtype() == ":"
            end,
          },
          ghost_text = { enabled = true },
        },
      },

      -- Keymaps (from nvim-old plugins.config.lsp.cmp)
      -- preset "default" leaves <CR> unmapped, like the old ["<CR>"] = vim.NIL
      keymap = {
        preset = "default",
        ["<C-l>"] = { "select_and_accept" }, -- confirm, selects first item if none selected
        ["<C-y>"] = { "select_and_accept" },
        ["<C-e>"] = { "show" },
        ["<C-f>"] = { "scroll_documentation_down" },
        ["<C-u>"] = { "scroll_documentation_up" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
    },

    opts_extend = { "sources.compat", "sources.default" },
  },
}
