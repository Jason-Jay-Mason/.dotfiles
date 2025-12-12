local ok, cmp = pcall(function()
	local c = require("cmp")
	return c
end)

if not ok then
	return
end

local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

cmp.setup({
	preselect = "item",
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	window = {
		completion = cmp.config.window.bordered({
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 1,
		}),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				nvim_lsp = "LSP",
				nvim_lua = "Nvim Lua",
				buffer = "Buffer",
				path = "Path",
			})[entry.source.name]
			return vim_item
		end,
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 3 },
	},

	mapping = cmp.mapping.preset.insert({
		-- confirm completion item
		["<C-l>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),

		["<C-e>"] = cmp.mapping.complete(),

		-- scroll documentation window
		["<C-f>"] = cmp.mapping.scroll_docs(5),
		["<C-u>"] = cmp.mapping.scroll_docs(-5),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<CR>"] = vim.NIL,
	}),
	snippet = {},
})
