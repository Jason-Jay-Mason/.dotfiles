local ok, cmp = pcall(require, "cmp_nvim_lsp")

if not ok then
	return
end

-- This is to make cmp work
vim.lsp.config("*", {
	capabilities = cmp.default_capabilities(),
})

--Configure diagnostics
vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	float = {
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})
