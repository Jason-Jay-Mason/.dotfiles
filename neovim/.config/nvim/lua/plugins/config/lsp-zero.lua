local ok, lsp = pcall(require, "lsp-zero")
if not ok then
  return
end

local lsp_attach = function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({ buffer = bufnr })
end




lsp.extend_lspconfig({
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  lsp_attach = lsp_attach,
  float_border = 'rounded',
  sign_text = {
    error = " ",
    warn = " ",
    hint = " ",
    info = " ",
  },
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        on_init = function(client)
          lsp.nvim_lua_settings(client, {})
        end,
      })
    end,
  }
})

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
  float = {
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

require("plugins.config.cmp")



-- custom lsp configuration
local config = require("lspconfig")
local utils = require("utils")

config.phpactor.setup({
  filetypes = { "php" }
})

-- config.htmx.setup({
--   filetypes = { "html", "templ" },
-- })

-- config.tailwindcss.setup({
--   filetypes = { "svelte", "html", "templ", "tsx" },
--   root_dir = config.util.root_pattern("tsconfig.json", "package.json", ".git", "Makefile"),
--   init_options = {
--     userLanguages = {
--       templ = "html",
--     },
--   },
-- })

-- config.unocss.setup({
--   filetypes = { "svelte", "html", "templ", "tsx" },
--   root_dir = config.util.root_pattern("tsconfig.json", "package.json", ".git", "Makefile"),
--   init_options = {
--     userLanguages = {
--       templ = "html",
--     },
--   },
-- })

config.templ.setup({})

-- volar did an update that broke ts support so this is needed
-- https://github.com/vuejs/language-tools/issues/3925
config.tsserver.setup({
  filetypes = { "svelte", "ts", "tsx", "vue" },
  root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = { "typescript", "vue" },
      },
    },
  },
})

config.volar.setup({
  filetypes = utils.has_npm_package("vue") and { "typescript", "javascript", "vue", "json" } or { "vue" },
  root_dir = config.util.root_pattern("package.json"),
  documentFeatures = {
    documentFormatting = {
      defaultPrintWidth = 60,
    },
  },
})


-- Guard
local ok2, ft = pcall(require, "guard.filetype")
if not ok2 then
  return
end

ft('typescript,javascript,typescriptreact'):fmt('prettier')


require('guard').setup({
  -- Choose to format on every write to a buffer
  fmt_on_save = true,
  -- Use lsp if no formatter was defined for this filetype
  lsp_as_default_formatter = false,
})

-- vim.lsp.set_log_level('debug')
