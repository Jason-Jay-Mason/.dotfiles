local ok, config = pcall(require, "lspconfig")
local utils = require("utils")

if not ok then
  return
end

-- vim.lsp.set_log_level('debug')

config.phpactor.setup({
  filetypes = { "php" }
})

config.templ.setup({})



-- HACK:Svelte has a noob lsp implimentation, therefore they depened on vs code's file watching, we need to mimick that here and let svelte ls know when a ts or js file has changed
config.svelte.setup({
  on_attach = function(client)
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.js", "*.ts" },
      group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
      callback = function(ctx)
        -- Here use ctx.match instead of ctx.file
        client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
      end,
    })
  end
})


-- config.htmx.setup({
--   filetypes = { "html", "templ" },
-- })

-- config.tailwindcss.setup({
--   filetypes = { "svelte", "html", "templ", "tsx" },
--   root_dir = config.util.root_pattern("tsconfig.json", "package.json", ".git", "Makefile"),
--   init_options = {
--     userLanguages = {
--       templ = "html",
--     },
--   },
-- })

-- config.unocss.setup({
--   filetypes = { "svelte", "html", "templ", "tsx" },
--   root_dir = config.util.root_pattern("tsconfig.json", "package.json", ".git", "Makefile"),
--   init_options = {
--     userLanguages = {
--       templ = "html",
--     },
--   },
-- })

-- volar did an update that broke ts support so this is needed
-- https://github.com/vuejs/language-tools/issues/3925
-- config.ts_ls.setup({
--   filetypes = { "svelte", "ts", "tsx", "vue" },
--   root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
--   init_options = {
--     plugins = {
--       {
--         name = "@vue/typescript-plugin",
--         location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
--         languages = { "typescript", "vue" },
--       },
--     },
--   },
-- })

-- config.volar.setup({
--   filetypes = utils.has_npm_package("vue") and { "typescript", "javascript", "vue", "json" } or { "vue" },
--   root_dir = config.util.root_pattern("package.json"),
--   documentFeatures = {
--     documentFormatting = {
--       defaultPrintWidth = 60,
--     },
--   },
-- })
