local function get_popup_size()
  local screen_w = vim.opt.columns:get()
  local screen_h = vim.opt.lines:get()
  local window_w = screen_w * 1
  local window_h = screen_h * 0.99
  return {
    screen_w = screen_w,
    screen_h = screen_h,
    center_x = (screen_w - window_w) / 2,
    window_w = math.floor(window_w),
    window_h = math.floor(window_h),
  }
end

local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.map.on_attach.default(bufnr)

  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Node"))
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open Node"))
end

return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    keys = {
      { "<leader>t", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree Toggle" },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      on_attach = on_attach,
      filters = {
        git_ignored = false,
        custom = { ".*_templ.go", "venv", "node_modules" },
      },
      view = {
        width = function()
          return get_popup_size().screen_w
        end,
        number = true,
        relativenumber = true,
        float = {
          enable = true,
          open_win_config = function()
            local win = get_popup_size()
            return {
              border = "none",
              relative = "editor",
              row = win.screen_h,
              col = win.center_x,
              width = win.window_w,
              height = win.window_h,
            }
          end,
        },
      },
    },
  },
}
