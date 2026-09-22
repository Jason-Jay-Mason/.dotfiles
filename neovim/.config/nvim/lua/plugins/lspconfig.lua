return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", cmd = "Mason", opts = {} },
      { "mason-org/mason-lspconfig.nvim", config = function() end },
    },
    config = function()
      -- Diagnostics (from nvim-old plugins.config.lsp.config)
      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "\u{f057} ",
            [vim.diagnostic.severity.WARN] = "\u{f071} ",
            [vim.diagnostic.severity.HINT] = "\u{f05a} ",
            [vim.diagnostic.severity.INFO] = "\u{f059} ",
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

      -- Server configs (from nvim-old plugins.config.lsp.servers)

      -- HACK: Svelte has a noob lsp implementation, therefore they depend on vs code's file
      -- watching, we need to mimic that here and let svelte ls know when a ts or js file has changed
      vim.lsp.config("svelte", {
        on_attach = function(client)
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
            callback = function(ctx)
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
            end,
          })
        end,
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              features = "all",
            },
          },
        },
      })

      -- Keymaps (from nvim-old settings.mappings M.lsp)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(event)
          local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = event.buf, silent = true, desc = "LSP: " .. desc })
          end
          map("ge", vim.diagnostic.open_float, "Diagnostics")
          map("gh", vim.lsp.buf.hover, "Hover")
          map("gr", vim.lsp.buf.references, "References")
          map("gi", vim.lsp.buf.implementation, "Implementation")
          map("gf", vim.lsp.buf.definition, "Definition")
          map("gD", vim.lsp.buf.declaration, "Declaration")
        end,
      })

      require("mason-lspconfig").setup({})
    end,
  },
}
