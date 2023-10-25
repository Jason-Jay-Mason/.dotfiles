local ok, nvimtree = pcall(require, 'nvim-tree')

if not ok then
  return
end

-- Helper function to allow the popup to be fullscreen no matter what
local get_window = require('utils').get_popup_size

-- For some reason the implmented this on_attach func. I have to declare mappings here Annoying
-- Docs are here https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach
local function on_attach(bufnr)
  local ok, api = pcall(require, 'nvim-tree.api')
  if not ok then
    return
  end
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  -- Apply the default keymapings
  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Node'))
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open Node'))
end


nvimtree.setup({
  on_attach = on_attach,
  view = {
    width = function()
      local win = get_window()
      return win.screen_w
    end,
    number = true,
    relativenumber = true,
    float = {
      enable = true,
      open_win_config = function()
        local win = get_window()
        return {
          border = "none",
          relative = "editor",
          row = win.screen_h,
          col = win.center_x,
          width = win.window_w,
          height = win.window_h,
        }
      end
    },
  },
}
)
