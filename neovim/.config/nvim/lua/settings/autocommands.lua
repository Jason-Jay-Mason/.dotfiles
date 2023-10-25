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

-- To open all new buffers as full windows
local fullScreenFileTypes = { 'qf' }
api.nvim_create_autocmd("BufRead", {
  callback = function()
    vim.schedule(function()
      for i = 1, #fullScreenFileTypes do
        local filetype = fullScreenFileTypes[i]
        if vim.bo.filetype == filetype then
          vim.cmd('resize 100')
        end
      end
    end)
  end
})

api.nvim_create_autocmd("BufAdd", {
  callback = function()
    vim.schedule(function()
      vim.cmd('only')
    end)
  end
})
