local map = vim.keymap.set
local opts = { silent = true }

-- Space is the leader; don't let it move the cursor
map("", "<Space>", "<Nop>", opts)

-- Ctrl+s: format with the LSP (if an attached client supports it), then save.
-- Stays in insert mode.
map({ "n", "i", "x" }, "<C-s>", function()
  if #vim.lsp.get_clients({ bufnr = 0, method = "textDocument/formatting" }) > 0 then
    vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
  end
  vim.cmd("write")
end, { desc = "Format and save", silent = true })

-- Reset the file to before changes
map("n", "<C-r>", "<cmd>edit!<cr>", { desc = "Revert file", silent = true })

-- Make every cut (c{motion}, cc, C, visual c) stay in normal mode.
-- `c`/`C` run natively (so counts, registers, text objects and special cases
-- like `cw` behave as usual). A flag is set, and the InsertEnter that the cut
-- triggers immediately stops insert mode. SafeState clears the flag if the
-- operator gets cancelled (e.g. `c<Esc>`), since it only fires once no operator
-- is pending, so the flag never leaks onto a later `i`/`a`/`o`.
local cut_pending = false
local cut_group = vim.api.nvim_create_augroup("CutStaysNormal", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  group = cut_group,
  callback = function()
    if cut_pending then
      cut_pending = false
      vim.cmd("stopinsert")
    end
  end,
})

vim.api.nvim_create_autocmd("SafeState", {
  group = cut_group,
  callback = function()
    cut_pending = false
  end,
})

local function cut(key)
  return function()
    cut_pending = true
    return key
  end
end

map({ "n", "x" }, "c", cut("c"), { expr = true, silent = true, desc = "Cut (stay in normal mode)" })
map({ "n", "x" }, "C", cut("C"), { expr = true, silent = true, desc = "Cut to end (stay in normal mode)" })

-- Make delete a different thing than cut: every delete goes to the black-hole
-- register, so it never touches the unnamed/numbered/small-delete registers.
-- Only the operator key is remapped, so the rest (motion, text object, `dd`,
-- counts) is typed natively: `d3w` -> `"_d3w`, `dd` -> `"_dd`, `5x` -> `5"_x`.
for _, key in ipairs({ "d", "D", "x", "X", "<Del>" }) do
  map({ "n", "x" }, key, '"_' .. key, { silent = true, desc = "Delete (no register)" })
end
