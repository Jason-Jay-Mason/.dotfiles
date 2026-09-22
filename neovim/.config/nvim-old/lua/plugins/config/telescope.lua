local ok, telescope = pcall(require, "telescope")

if not ok then
  return
end

local get_window = require("utils").get_popup_size


local actions = require("telescope.actions")


telescope.setup({
  defaults = {
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    },
    file_ignore_patterns = { "node_modules", "tmp", ".*_templ.go", ".*.min.js", "venv" },
    results_title = false,
    dynamic_preview_title = true,
    prompt_prefix = "   ",
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
      },
      width = function()
        local win = get_window()
        return win.window_w
      end,
      height = function()
        local win = get_window()
        return win.window_h
      end,
    },
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
      },
    },
  },
})

telescope.load_extension("media_files")
telescope.load_extension("fzf")
