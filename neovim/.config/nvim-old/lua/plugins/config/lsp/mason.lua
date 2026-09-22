local ok, mason, masonLspConf = pcall(function()
  local m = require("mason")
  local mc = require("mason-lspconfig")
  return m, mc 
end)

if not ok then
  return
end


mason.setup({})
masonLspConf.setup({})

