local ok, lsp, mason, masonLspConf, config = pcall(function()
  local l = require("lsp-zero")
  local m = require("mason")
  local mc = require("mason-lspconfig")
  local c = require("lspconfig")
  return l, m, mc, c
end)

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

mason.setup({})
masonLspConf.setup({
  ensure_installed = {},
  handlers = {
    function(server_name)
      config[server_name].setup({})
    end,
    lua_ls = function()
      config.lua_ls.setup({
        on_init = function(client)
          lsp.nvim_lua_settings(client, {})
        end,
      })
    end,
  }
})

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
})
