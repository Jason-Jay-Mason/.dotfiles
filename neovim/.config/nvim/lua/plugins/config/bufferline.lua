local ok, bufferline = pcall(require, 'bufferline')

if not ok then
  return
end

bufferline.setup({
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
    indicator = {
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
      style = 'icon',
    },
    modified_icon = '󰳼 ',
    truncate_names = false, -- whether or not tab names should be truncated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_on_event = true, -- use nvim's diagnostic handler
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true
      }
    },
    color_icons = true, -- whether or not to add the filetype icon highlights
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
    persist_buffer_sort = true,   -- whether or not custom sorted buffers should persist
    move_wraps_at_ends = false,   -- whether or not the move command "wraps" at the first or last position
    separator_style = "thin",
    hover = {
      enabled = true,
      delay = 200,
    },
  }
})
