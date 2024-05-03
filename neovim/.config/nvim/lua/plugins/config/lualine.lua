local ok, lualine = pcall(require, 'lualine')

if not ok then
  return
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = "#ffffff", bg = "none" } },
      inactive = { c = { fg = "#ffffff", bg = "none" } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left({
  'mode',
  fmt = function(name, _)
    return "†"
  end,
  color = { fg = 'white', gui = 'bold' },
  padding = { right = 1 },
})

ins_left({ "progress", color = { fg = 'white', gui = 'bold' } })

ins_left({
  "filename",
  path = 1,
  cond = conditions.buffer_not_empty,
  color = { fg = 'white', gui = "italic" },
})

ins_left({
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = { info = " ", warn = " ", error = " " },
  diagnostics_color = {
    color_info = { fg = 'white' },
    color_warn = { fg = 'white' },
    color_error = { fg = 'white' },
  },
})

ins_right({
  "diff",
  symbols = { added = " ", modified = " ", removed = " " },
  diff_color = {
    added = { fg = 'white' },
    modified = { fg = 'white' },
    removed = { fg = 'white' },
  },
  cond = conditions.hide_in_width,
})


ins_right({
  -- Lsp server name .
  function()
    local msg = "none"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()

    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      -- and vim.fn.index(filetypes, buf_ft) ~= -1
      if filetypes then
        if msg == "none" then
          msg = client.name
        else
          msg = msg .. "," .. client.name
        end
      end
    end
    return msg
  end,
  icon = "",
  color = { fg = 'white', gui = "italic" },
})

ins_right({
  "branch",
  icon = "",
  color = { fg = 'white', gui = 'bold' },
})

lualine.setup(config)
