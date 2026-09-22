return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
    version = false,
    lazy = false,
    build = function()
      local TS = require("nvim-treesitter")
      if not TS.get_installed then
        vim.notify("Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.", vim.log.levels.ERROR)
        return
      end
      TS.update(nil, { summary = true })
    end,
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    opts_extend = { "ensure_installed" },
    opts = {
      indent = { enable = true },
      highlight = { enable = true },
      folds = { enable = false},
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "svelte",
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter")

      setmetatable(require("nvim-treesitter.install"), {
        __newindex = function(_, k)
          if k == "compilers" then
            vim.schedule(function()
              vim.notify("Setting custom compilers for `nvim-treesitter` is no longer supported.", vim.log.levels.ERROR)
            end)
          end
        end,
      })

      if not TS.get_installed then
        return vim.notify("Please use `:Lazy` and update `nvim-treesitter`", vim.log.levels.ERROR)
      elseif type(opts.ensure_installed) ~= "table" then
        return vim.notify("`nvim-treesitter` opts.ensure_installed must be a table", vim.log.levels.ERROR)
      end

      TS.setup(opts)

      local installed, queries = {}, {}

      local function get_installed(update)
        if update then
          installed, queries = {}, {}
          for _, lang in ipairs(TS.get_installed("parsers")) do
            installed[lang] = true
          end
        end
        return installed
      end

      local function have_query(lang, query)
        local key = lang .. ":" .. query
        if queries[key] == nil then
          local ok, q = pcall(vim.treesitter.query.get, lang, query)
          queries[key] = ok and q ~= nil
        end
        return queries[key]
      end

      local function have(what, query)
        what = what or vim.api.nvim_get_current_buf()
        what = type(what) == "number" and vim.bo[what].filetype or what
        local lang = vim.treesitter.language.get_lang(what)
        if lang == nil or get_installed()[lang] == nil then
          return false
        end
        if query and not have_query(lang, query) then
          return false
        end
        return true
      end

      _G.ts_foldexpr = function()
        return have(vim.api.nvim_get_current_buf(), "folds") and vim.treesitter.foldexpr() or "0"
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        callback = function(ev)
          if not have(ev.match) then
            return
          end

          if have(ev.match, "highlights") then
            pcall(vim.treesitter.start, ev.buf)
          end

          if have(ev.match, "indents") then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      get_installed(true)

      local install = vim.tbl_filter(function(lang)
        return not have(lang)
      end, opts.ensure_installed)
      if #install > 0 then
        local task = TS.install(install, { summary = true })
        task:await(function()
          get_installed(true)
        end)
        if #vim.api.nvim_list_uis() == 0 then
          task:wait(300000)
        end
      end
    end,
  },
}
