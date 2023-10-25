local ok, blankline = pcall(require, 'indent_blankline')

if not ok then
  return
end

vim.opt.list = true

blankline.setup({
  show_end_of_line = true,
  show_current_context = true,
  show_current_context_start = true,
  char_highlight_list = {
    "IndentBlankLineIndent1",
  }
})
