local ok, ft = pcall(require, "guard.filetype")
if not ok then
  return
end

ft('typescript,javascript,typescriptreact'):fmt('prettier')


require('guard').setup({
  -- Choose to format on every write to a buffer
  fmt_on_save = true,
  -- Use lsp if no formatter was defined for this filetype
  lsp_as_default_formatter = false,
})
