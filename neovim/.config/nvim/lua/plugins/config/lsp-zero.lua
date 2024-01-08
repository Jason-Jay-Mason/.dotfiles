local ok, lsp = pcall(require, "lsp-zero")
if not ok then
	return
end

require("plugins.config.cmp")

lsp.preset({
	name = "minimal",
	set_lsp_keymaps = true,
	manage_nvim_cmp = false,
	suggest_lsp_servers = true,
})

lsp.set_sign_icons({
	error = " ",
	warn = " ",
	hint = " ",
	info = " ",
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

-- I had to fix the unocss lsp myself this is not loaded via mason
local config = require("lspconfig")
config.tailwindcss.setup({
	filetypes = { "svelte", "html", "templ" },
	root_dir = config.util.root_pattern("tsconfig.json", "package.json", ".git", "Makefile"),
	init_options = {
		userLanguages = {
			templ = "html",
		},
	},
})
config.templ.setup({})

-- vim.lsp.set_log_level('debug')

--null ls
local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)
	end,
	sources = {
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
	},
})
