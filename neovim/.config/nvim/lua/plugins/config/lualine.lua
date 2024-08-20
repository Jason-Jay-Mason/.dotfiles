local ok, lualine = pcall(require, 'lualine')

if not ok then
  return
end
local ok2, palette = pcall(require, 'settings.colors')

if not ok2 then
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

local theme = {
  normal = {
    a = { fg = palette.fg_med, gui = 'bold' },
    b = { bg = palette.fg_med, fg = palette.bg_darker },
    c = { fg = palette.fg_med },
  },
  insert = {
    a = { fg = palette.green, gui = 'bold' },
    b = { bg = palette.green, fg = palette.bg_darker },
    c = { fg = palette.green },
  },
  visual = {
    a = { fg = palette.yellow, gui = 'bold' },
    b = { bg = palette.yellow, fg = palette.bg_darker },
    c = { fg = palette.yellow },
  },
  replace = {
    a = { fg = palette.magenta, gui = 'bold' },
    b = { bg = palette.magenta, fg = palette.bg_darker },
    c = { fg = palette.magenta },
  },
  command = {
    a = { fg = palette.red, gui = 'bold' },
    b = { bg = palette.red, fg = palette.bg_darker },
    c = { fg = palette.red },
  },
  inactive = {
    a = { fg = palette.subtle, gui = 'bold' },
    b = { bg = palette.subtle, fg = palette.bg_darker },
    c = { fg = palette.subtle },
  },
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = theme,
    always_divide_middle = true,
    globalstatus = false,
    component_separators = "",
    section_separators = "",
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },

  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(name, _)
          return "✝"
        end,
        padding = { right = 1 },
      }
    },
    lualine_b = {
      {
        "progress",
      },
    },
    lualine_c = {
      {
        "filename",
        path = 1,
        cond = conditions.buffer_not_empty,
        color = { fg = palette.fg_med, gui = "italic" },
      }
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { info = " ", warn = " ", error = " " },
        diagnostics_color = {
          color_info = { fg = palette.blue },
          color_warn = { fg = palette.yellow },
          color_error = { fg = palette.red },
          color_hint = { fg = palette.green },
        },
      },
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = palette.green },
          modified = { fg = palette.yellow },
          removed = { fg = palette.red },
        },
        cond = conditions.hide_in_width,
      },
      {
        -- Lsp server name .
        function()
          local msg = "none"
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
        color = { fg = palette.fg_med, gui = "italic" },
      },
      {
        "branch",
        icon = "",
        color = { fg = palette.fg_med, gui = 'bold' },
      }

    },
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
})



-- ins_left({
--   "diagnostics",
--   sources = { "nvim_diagnostic" },
--   symbols = { info = " ", warn = " ", error = " " },
--   diagnostics_color = {
--     color_info = { fg = 'white' },
--     color_warn = { fg = 'white' },
--     color_error = { fg = 'white' },
--   },
-- })
--
-- ins_right({
--   "diff",
--   symbols = { added = " ", modified = " ", removed = " " },
--   diff_color = {
--     added = { fg = 'white' },
--     modified = { fg = 'white' },
--     removed = { fg = 'white' },
--   },
--   cond = conditions.hide_in_width,
-- })
--
--
-- ins_right({
--   -- Lsp server name .
--   function()
--     local msg = "none"
--     local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
--     local clients = vim.lsp.get_active_clients()
--
--     for _, client in ipairs(clients) do
--       local filetypes = client.config.filetypes
--       -- and vim.fn.index(filetypes, buf_ft) ~= -1
--       if filetypes then
--         if msg == "none" then
--           msg = client.name
--         else
--           msg = msg .. "," .. client.name
--         end
--       end
--     end
--     return msg
--   end,
--   icon = "",
--   color = { fg = 'white', gui = "italic" },
-- })
--
-- ins_right({
--   "branch",
--   icon = "",
--   color = { fg = 'white', gui = 'bold' },
-- })
--
-- lualine.setup(config)
