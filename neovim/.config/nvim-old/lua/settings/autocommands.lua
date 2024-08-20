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

--HACK: this is needed because of the stupid svelte lsp, for some reason it is not seeing new exports in ts files
function on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

on_attach(function(client, _)
	if client.name == "svelte" then
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.js", "*.ts" },
			callback = function(ctx)
				client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
			end,
		})
	end
end)

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
