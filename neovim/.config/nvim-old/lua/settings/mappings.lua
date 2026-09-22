local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

map("", "<Space>", "<Nop>", default_opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = " "

local M = {}
M.nvim = {
  n = {
    -- Make cut not go into insert mode for the majority of use cases
    ['cc'] = 'cc<Esc>',
    ['ci{'] = 'ci{<Esc>',
    ['ci}'] = 'ci}<Esc>',
    ['ci['] = 'ci]<Esc>',
    ['ci('] = 'ci(<Esc>',
    ['cw'] = 'cw<Esc>',
    -- Reset the file to before changes
    ["<C-r>"] = "<cmd>edit!<cr>",
    -- crl s save
    ["<C-s>"] = "<cmd>lua vim.lsp.buf.format() vim.cmd('w') <cr>",
    -- Make detelete a different thing than cut ie make it not copy
    ["x"] = '"_x',
    ['d'] = '"_d',
  },
  i = {
    -- ctr s save
    ["<C-s>"] = "<cmd>lua vim.lsp.buf.format() vim.cmd('w') <cr>",
  },
  v = {
    -- Make delete not copy to register
    ["x"] = '"_x',
    --Make cut not go into insert mode
    ['c'] = 'c<Esc>',
  }
}

M.lsp = {
  n = {
    ['ge'] = '<cmd>lua vim.diagnostic.open_float()<CR>',
    ['gh'] = '<cmd>lua vim.lsp.buf.hover()<CR>',
    ['gr'] = '<cmd>lua vim.lsp.buf.references()<CR>',
    ['gi'] = '<cmd>lua vim.lsp.buf.implementation()<CR>',
    ['gf'] = '<cmd>lua vim.lsp.buf.definition()<CR>',
    ['gD'] = '<cmd>lua vim.lsp.buf.declaration()<CR>',
    -- ['gt'] = '<cmd>lua vim.lsp.buf.type_definition()<CR>',
  }
}

M.telescope = {
  n = {
    ['<leader>f'] = '<cmd>Telescope find_files<cr>',
    ['<leader>e'] = '<cmd>Telescope diagnostics<cr>',
    ['<leader>g'] = '<cmd>Telescope live_grep<cr>',
  }
}

M.neogit = {
  n = {
    ['<leader>G'] = '<cmd>Neogit<cr>',
  }
}

M.bufferline = {
  n = {
    -- close buffer window
    ["<C-w>"] = "<cmd>bdelete<cr>",
    -- Navigate buffers
    ["<S-l>"] = ":bnext<CR>",
    ["<S-h>"] = ":bprevious<CR>",
  }
}

M.nvimtree = {
  n = {
    ["<leader>t"] = ":NvimTreeToggle<cr>",
  }
}

-- Set up keymaps
for _, modes in pairs(M) do
  for mode, mappings in pairs(modes) do
    for mapping, action in pairs(mappings) do
      map(mode, mapping, action.payload or action, action.opts or default_opts)
    end
  end
end

return M
