local api = vim.api
-- Set the command height when recording macros
api.nvim_create_autocmd({ "RecordingEnter" }, {
  callback = function()
    vim.opt.cmdheight = 1
  end,
})

api.nvim_create_autocmd({ "RecordingLeave" }, {
  callback = function()
    vim.opt.cmdheight = 0
  end,
})


-- Make md files wrap so that reading md is more pleasant
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "mdx" }, -- List of file types to match
  group = md_group,                -- Assign to the created group
  callback = function()
    -- Lua function to be executed when the event occurs
    vim.opt_local.wrap = true  -- Enable line wrap
    vim.opt_local.spell = true -- Enable spell check
    vim.opt_local.linebreak = true
    -- Add any other settings here
  end,
})

--HACK: this is needed because of the stupid svelte lsp, for some reason it is not seeing new exports in ts files

-- To open all new buffers as full windows
local fullScreenFileTypes = { "qf" }
api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.schedule(function()
      for i = 1, #fullScreenFileTypes do
        local filetype = fullScreenFileTypes[i]
        if vim.bo.filetype == filetype then
          vim.cmd("resize 100")
        end
      end
    end)
  end,
})

api.nvim_create_autocmd("BufAdd", {
  callback = function()
    vim.schedule(function()
      vim.cmd("only")
    end)
  end,
})
