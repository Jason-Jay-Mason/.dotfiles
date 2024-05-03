local ok, lsp = pcall(require, "lsp-zero")
if not ok then
  return
end

require("plugins.config.cmp")

--initial setup
lsp.preset({
  name = "minimal",
  set_lsp_keymaps = true,
  manage_nvim_cmp = false,
  suggest_lsp_servers = true,
})
lsp.set_sign_icons({
  error = " ",
  warn = " ",
  hint = " ",
  info = " ",
})
lsp.nvim_workspace()
lsp.setup()

-- custom lsp configuration
local config = require("lspconfig")
local utils = require("utils")

config.htmx.setup({
  filetypes = { "html", "templ" },
})

config.tailwindcss.setup({
  filetypes = { "svelte", "html", "templ" },
  root_dir = config.util.root_pattern("tsconfig.json", "package.json", ".git", "Makefile"),
  init_options = {
    userLanguages = {
      templ = "html",
    },
  },
})

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
