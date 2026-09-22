return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    keys = {
      { "<C-w>", "<cmd>bdelete<cr>", desc = "Delete buffer" },
      { "<S-l>", "<cmd>bnext<cr>", desc = "Next buffer" },
      { "<S-h>", "<cmd>bprevious<cr>", desc = "Previous buffer" },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        mode = "buffers",
        indicator = {
          icon = "▎",
          style = "icon",
        },
        modified_icon = "󰳼 ",
        truncate_names = false,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_on_event = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
        color_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        move_wraps_at_ends = false,
        separator_style = "thin",
        hover = {
          enabled = true,
          delay = 200,
        },
      },
    },
  },
}
