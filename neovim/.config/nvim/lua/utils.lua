local M = {}

local opt = vim.opt

M.ensure_lazynvim = function()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out,                            "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)
end

M.has_npm_package = function(package_name)
  local package_json_path = vim.fn.getcwd() .. "/package.json"

  if vim.fn.filereadable(package_json_path) == 0 then
    return false
  end

  local package_json_content = vim.fn.readfile(package_json_path)

  for _, line in ipairs(package_json_content) do
    if vim.fn.match(line, '"' .. package_name .. '"') > -1 then
      return true
    end
  end

  return false
end

M.set_highlight_groups = function(highlight_group)
  for name, value in pairs(highlight_group) do
    vim.api.nvim_set_hl(0, string.format("%s", name), value)
  end
end

M.get_popup_size = function()
  local screen_w = opt.columns:get()
  local screen_h = opt.lines:get()
  local window_w = screen_w * 1
  local window_h = screen_h * 0.98
  local window_w_int = math.floor(window_w)
  local window_h_int = math.floor(window_h)
  local center_x = (screen_w - window_w) / 2
  local center_y = ((opt.lines:get() - window_h) / 2)
  return {
    screen_w = screen_w,
    screen_h = screen_h,
    center_x = center_x,
    center_y = center_y,
    window_w = window_w_int,
    window_h = window_h_int,
  }
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
