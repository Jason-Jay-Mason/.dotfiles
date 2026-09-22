local ok, palette = pcall(require, 'settings.colors')

if not ok then
  return
end

vim.cmd.colorscheme(palette.theme)
vim.cmd.highlight('normal guibg=none')

-- Get all highlights: so $VIMRUNTIME/syntax/hitest.vim
local highlight_groups = {
  --- Blank line indent
  ['ibl.indent.char.1'] = { fg = palette.cyan },
  -- Telescope
  NormalNC = { bg = palette.none },
  TelescopeNormal = { bg = palette.none },
  TelescopeBorder = { bg = palette.none },
  TelescopePreviewBorder = { fg = palette.none, bg = palette.none },
  TelescopePreviewNormal = { bg = palette.none },
  TelescopePreviewTitle = { fg = palette.none },
  TelescopePromptBorder = { fg = palette.bg_darker, bg = palette.bg_darker },
  TelescopePromptNormal = { bg = palette.bg_darker },
  TelescopePromptTitle = { fg = palette.bg_darker },
  TelescopeResultsBorder = { fg = palette.bg, bg = palette.bg },
  TelescopeResultsNormal = { bg = palette.bg },
  TelescopeResultsTitle = { fg = palette.bg },
  -- This one is for lsp suggestion menue
  Pmenu = { fg = palette.fg_med, bg = palette.none },
  -- Bufferline
  BufferLineBufferSelected = { bg = palette.bg_darker, fg = palette.fg },
  BufferLineFill = { bg = palette.none },
  BufferLineTab = { bg = palette.none },

  BufferLineOffsetSeparator = { bg = palette.none, fg = palette.none },
  BufferLinePickVisible = { bg = palette.none },
  BufferLinePickSelected = { bg = palette.bg_darker },
  BufferLineIndicatorVisible = { bg = palette.none },
  BufferLineIndicatorSelected = { bg = palette.green, fg = palette.bg },
  BufferLineTabSeparatorSelected = { bg = palette.green },
  BufferLineTabSeparator = { bg = palette.none },
  BufferLineError = { bg = palette.none, fg = palette.red },
  BufferLineSeparatorSelected = { bg = palette.bg_darker },
  BufferLineDuplicate = { bg = palette.none },
  BufferLineDuplicateVisible = { bg = palette.none },
  BufferLineDuplicateSelected = { bg = palette.bg_darker },
  BufferLineModifiedSelected = { bg = palette.bg_darker, fg = palette.yellow },
  BufferLineModifiedVisible = { bg = palette.none },
  BufferLineErrorDiagnosticSelected = { bg = palette.bg_darker },
  BufferLineErrorDiagnosticVisible = { bg = palette.none },
  BufferLineErrorDiagnostic = { bg = palette.none },
  BufferLineErrorSelected = { bg = palette.bg_darker },
  BufferLineErrorVisible = { bg = palette.none },
  BufferLineWarningDiagnosticSelected = { bg = palette.bg_darker },
  BufferLineTabClose = { bg = palette.none },
  BufferLineTabSelected = { bg = palette.bg_darker },
  BufferLineGroupLabel = { bg = palette.none },
  BufferLineGroupSeparator = { bg = palette.none },
  BufferLineTruncMarker = { bg = palette.none },
  BufferLineInfoDiagnostic = { bg = palette.none },
  BufferLineInfo = { bg = palette.none },
  BufferLineInfoVisible = { bg = palette.none },
  BufferLineBuffer = { bg = palette.none },
  BufferLineHintDiagnosticVisible = { bg = palette.none },
  BufferLineHintDiagnostic = { bg = palette.none },
  BufferLineHintSelected = { bg = palette.bg_darker },
  BufferLineHintVisible = { bg = palette.none },
  BufferLineDiagnosticSelected = { bg = palette.bg_darker },
  BufferLineDiagnosticVisible = { bg = palette.none },
  BufferLineNumbersVisible = { bg = palette.none },
  BufferLineNumbersSelected = { bg = palette.bg_darker },
  BufferLineNumbers = { bg = palette.none },
  BufferLineBufferVisible = { bg = palette.none },
  BufferLineCloseButtonSelected = { bg = palette.bg_darker },
  BufferLineCloseButtonVisible = { bg = palette.none },
  BufferLineSeparator = { bg = palette.none, fg = palette.bg_light },
  BufferLineHint = { bg = palette.none },
  BufferLineCloseButton = { bg = palette.none },
  BufferLineDiagnostic = { bg = palette.none },
  BufferLineBackground = { bg = palette.none },
  BufferLineHintDiagnosticSelected = { bg = palette.bg_darker },
  BufferLineInfoSelected = { bg = palette.bg_darker },
  BufferLineInfoDiagnosticVisible = { bg = palette.none },
  BufferLineWarningVisible = { bg = palette.none },
  BufferLineInfoDiagnosticSelected = { bg = palette.bg_darker },
  BufferLineWarning = { bg = palette.none },
  BufferLinePick = { bg = palette.none },
  BufferLineWarningSelected = { bg = palette.bg_darker },
  BufferLineWarningDiagnostic = { bg = palette.none },
  BufferLineWarningDiagnosticVisible = { bg = palette.none },
  BufferLineModified = { bg = palette.none, fg = palette.yellow },
  BufferLineSeparatorVisible = { bg = palette.none },
  --Avante
  AvanteTitle = { bg = palette.bg, fg = palette.bg },
}


require('utils').set_highlight_groups(highlight_groups)
