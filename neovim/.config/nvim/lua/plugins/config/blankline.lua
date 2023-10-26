local ok, blankline = pcall(require, 'ibl')

if not ok  then
  return
end

vim.opt.list = true

vim.api.nvim_set_hl(0, "Indent", {fg="#1f1d2e"})

blankline.setup({
  indent = {
    highlight = "Indent",
    char = "┊"
  },
  scope = {
    highlight = "Comment"
  }
})
