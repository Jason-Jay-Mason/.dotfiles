local ok, lsp = pcall(require, 'lsp-zero')
if not ok then
  return
end

require('plugins.config.cmp')

lsp.preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = false,
  suggest_lsp_servers = true,
})

lsp.set_sign_icons({
  error = ' ',
  warn = ' ',
  hint = ' ',
  info = ' ',
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

-- I had to fix the unocss lsp myself this is not loaded via mason
local config = require('lspconfig')
config.unocss.setup {}

-- vim.lsp.set_log_level('debug')
