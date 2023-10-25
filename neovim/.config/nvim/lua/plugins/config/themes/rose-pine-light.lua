local ok, rosepine = pcall(require, 'rose-pine')

if not ok then
  return
end

rosepine.setup({
  variant = 'dawn',
  dim_nc_background = true,
  disable_background = true,
  disable_float_background = true,
})

local palette = {
  bg_darker = '#ffffff',
  bg = '#f2f2f2',
  bg_light = '#191724',
  fg_med = '#191724',
  fg = '#191724',
  red = '#eb6f92',
  yellow = '#f6c177',
  cyan = '#ebbcba',
  green = '#31748f',
  blue = '#9ccfd8',
  magenta = '#c4a7e7',
  none = 'NONE',
}

-- Get all highlights: so $VIMRUNTIME/syntax/hitest.vim
local highlight_groups = {
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
  BufferLineBufferSelected = { bg = palette.none },
  BufferLineFill = { bg = palette.none },
  -- Lualine
  lualine_c_mode_normal = { fg = palette.fg_med, bold = true },
  lualine_c_mode_insert = { fg = palette.magenta, bold = true },
  lualine_c_mode_visual = { fg = palette.yellow, bold = true },
  lualine_c_mode_replace = { fg = palette.magenta, bold = true },
  lualine_c_mode_command = { fg = palette.red, bold = true },
  lualine_c_mode_terminal = { fg = palette.blue, bold = true },
  lualine_c_mode_inactive = { fg = palette.subtle, bold = true },
  lualine_c_progress_normal = { bg = palette.fg_med, fg = palette.bg_darker },
  lualine_c_progress_insert = { bg = palette.magenta, fg = palette.bg_darker },
  lualine_c_progress_visual = { bg = palette.yellow, fg = palette.bg_darker },
  lualine_c_progress_replace = { bg = palette.magenta, fg = palette.bg_darker },
  lualine_c_progress_command = { bg = palette.red, fg = palette.bg_darker },
  lualine_c_progress_terminal = { bg = palette.blue, fg = palette.bg_darker },
  lualine_c_progress_inactive = { bg = palette.subtle, fg = palette.bg_darker },
  lualine_c_filename_normal = { fg = palette.fg },
  lualine_c_filename_insert = { fg = palette.fg },
  lualine_c_filename_visual = { fg = palette.fg },
  lualine_c_filename_replace = { fg = palette.fg },
  lualine_c_filename_command = { fg = palette.fg },
  lualine_c_filename_terminal = { fg = palette.fg },
  lualine_c_filename_inactive = { fg = palette.fg },
  lualine_c_diagnostics_error_normal = { fg = palette.red },
  lualine_c_diagnostics_error_insert = { fg = palette.red },
  lualine_c_diagnostics_error_visual = { fg = palette.red },
  lualine_c_diagnostics_error_replace = { fg = palette.red },
  lualine_c_diagnostics_error_command = { fg = palette.red },
  lualine_c_diagnostics_error_terminal = { fg = palette.red },
  lualine_c_diagnostics_error_inactive = { fg = palette.red },
  lualine_c_diagnostics_warn_normal = { fg = palette.yellow },
  lualine_c_diagnostics_warn_insert = { fg = palette.yellow },
  lualine_c_diagnostics_warn_visual = { fg = palette.yellow },
  lualine_c_diagnostics_warn_replace = { fg = palette.yellow },
  lualine_c_diagnostics_warn_command = { fg = palette.yellow },
  lualine_c_diagnostics_warn_terminal = { fg = palette.yellow },
  lualine_c_diagnostics_warn_inactive = { fg = palette.yellow },
  lualine_c_diagnostics_info_normal = { fg = palette.blue },
  lualine_c_diagnostics_info_insert = { fg = palette.blue },
  lualine_c_diagnostics_info_visual = { fg = palette.blue },
  lualine_c_diagnostics_info_replace = { fg = palette.blue },
  lualine_c_diagnostics_info_command = { fg = palette.blue },
  lualine_c_diagnostics_info_terminal = { fg = palette.blue },
  lualine_c_diagnostics_info_inactive = { fg = palette.blue },
  lualine_c_diagnostics_hint_normal = { fg = palette.green },
  lualine_c_diagnostics_hint_insert = { fg = palette.green },
  lualine_c_diagnostics_hint_visual = { fg = palette.green },
  lualine_c_diagnostics_hint_replace = { fg = palette.green },
  lualine_c_diagnostics_hint_command = { fg = palette.green },
  lualine_c_diagnostics_hint_terminal = { fg = palette.green },
  lualine_c_diagnostics_hint_inactive = { fg = palette.green },
  lualine_x_diff_added_normal = { fg = palette.green },
  lualine_x_diff_added_insert = { fg = palette.green },
  lualine_x_diff_added_visual = { fg = palette.green },
  lualine_x_diff_added_replace = { fg = palette.green },
  lualine_x_diff_added_command = { fg = palette.green },
  lualine_x_diff_added_terminal = { fg = palette.green },
  lualine_x_diff_added_inactive = { fg = palette.green },
  lualine_x_diff_modified_normal = { fg = palette.yellow },
  lualine_x_diff_modified_insert = { fg = palette.yellow },
  lualine_x_diff_modified_visual = { fg = palette.yellow },
  lualine_x_diff_modified_replace = { fg = palette.yellow },
  lualine_x_diff_modified_command = { fg = palette.yellow },
  lualine_x_diff_modified_terminal = { fg = palette.yellow },
  lualine_x_diff_modified_inactive = { fg = palette.yellow },
  lualine_x_diff_removed_normal = { fg = palette.red },
  lualine_x_diff_removed_insert = { fg = palette.red },
  lualine_x_diff_removed_visual = { fg = palette.red },
  lualine_x_diff_removed_replace = { fg = palette.red },
  lualine_x_diff_removed_command = { fg = palette.red },
  lualine_x_diff_removed_terminal = { fg = palette.red },
  lualine_x_diff_removed_inactive = { fg = palette.red },
  lualine_x_branch_normal = { fg = palette.cyan, bold = true },
  lualine_x_branch_insert = { fg = palette.cyan, bold = true },
  lualine_x_branch_visual = { fg = palette.cyan, bold = true },
  lualine_x_branch_replace = { fg = palette.cyan, bold = true },
  lualine_x_branch_command = { fg = palette.cyan, bold = true },
  lualine_x_branch_terminal = { fg = palette.cyan, bold = true },
  lualine_x_branch_inactive = { fg = palette.cyan, bold = true }
}


vim.cmd.colorscheme('rose-pine')
vim.cmd.highlight('normal guibg=none')

require('utils').set_highlight_groups(highlight_groups)
