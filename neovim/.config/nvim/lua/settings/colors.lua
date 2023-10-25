-- This file manages the theme and exports the colors for universal use in plugins like lua line
-- TODO: need to add dracula theme for my other computer
-- NOTE: This is a configerable field
local theme = 'rose-pine'
-- options:
-- 1: rose-pine
-- 2: bluloco
-- 3: bluloco-macos
-- 4: dracula
-- 5: quantum
-- 6: rose-pine-light
---------------
--------
--

-- Check for config file
local fn = vim.fn
local found = fn.glob('~/.config/nvim/lua/plugins/config/themes/' .. theme .. '.lua')
if fn.empty(found) <= 0 then
  return theme
end

return 'rose-pine'
--#endregion
