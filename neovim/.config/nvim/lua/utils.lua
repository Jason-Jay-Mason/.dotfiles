local M = {}

local opt = vim.opt

M.set_highlight_groups = function(highlight_group)
  for name, value in pairs(highlight_group) do
    vim.api.nvim_set_hl(0, name, value)
  end
end

M.get_popup_size = function()
  local screen_w = opt.columns:get()
  local screen_h = opt.lines:get() - opt.cmdheight:get()
  local window_w = screen_w * 1
  local window_h = screen_h * 0.98
  local window_w_int = math.floor(window_w)
  local window_h_int = math.floor(window_h)
  local center_x = (screen_w - window_w) / 2
  local center_y = ((opt.lines:get() - window_h) / 2) - opt.cmdheight:get()
  return {
    screen_w = screen_w,
    screen_h = screen_h,
    center_x = center_x,
    center_y = center_y,
    window_w = window_w_int,
    window_h = window_h_int,
  }
end

M.ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    print "Cloning packer .."
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })

    --Install plugins
    vim.cmd 'packadd packer.nvim'
    require 'plugins'
    vim.cmd 'PackerSync'

    --
    vim.api.nvim_create_autocmd("User", {
      pattern = "PackerComplete",
      callback = function()
        vim.cmd "bw | silent! MasonInstallAll" -- close packer window
        require("packer").loader "nvim-treesitter"
      end,
    })
    return true
  end
  return false
end

M.merge_table = function(table, default)
  for key, value in pairs(default) do
    -- check to see if this default value is a table
    if type(value) == "table" then
      -- see if there is the same key in the provided table to merge with
      if type(table[key]) == "table" then
        -- recursivly look through this table and sort the values
        M.merge_table(table[key], default[key])
      else
        -- we have a mismatch where the default is a table and the provided is not, lets overwrite with the default value
        table[key] = value
      end
    else
      -- if we do not have the same type then replace the table with default
      if not (type(value) == type(table[key])) then
        table[key] = value
      end
      -- any left over value of table[key] is valid and should stay untouched
    end
  end
  return table
end

return M
