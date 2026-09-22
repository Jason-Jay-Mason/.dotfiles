local function get_popup_size()
  local screen_w = vim.opt.columns:get()
  local screen_h = vim.opt.lines:get()
  return {
    window_w = math.floor(screen_w * 1),
    window_h = math.floor(screen_h * 0.99),
  }
end

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>e", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    },
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", "tmp", ".*_templ.go", ".*.min.js", "venv" },
        results_title = false,
        dynamic_preview_title = true,
        prompt_prefix = " \u{F96D}  ",
        layout_strategy = "horizontal",
        borderchars = {
          prompt = { "", "", "", "", "", "", "", "" },
          results = { "", "", "", "", "", "", "", "" },
          preview = { "", "", "", "", "", "", "", "" },
        },
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
            preview_cutoff = 0,
            width = function()
              return get_popup_size().window_w
            end,
            height = function()
              return get_popup_size().window_h
            end,
          },
        },
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-c>"] = "close",
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },
}
