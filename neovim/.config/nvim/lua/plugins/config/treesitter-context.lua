local ok, treesitterContext = pcall(require, 'treesitter-context')

if not ok then
  return
end

treesitterContext.setup({
  enable = true,
})
