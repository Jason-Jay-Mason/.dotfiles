--dependencies
local ok, avante = pcall(function()
  require('img-clip').setup({})
  require('copilot').setup({})
  require('render-markdown').setup({})
  require('avante_lib').load()
  local a = require("avante")
  return a
end)
if not ok then
  return
end

avante.setup({
  ---@alias avante.ProviderName "claude" | "openai" | "azure" | "gemini" | "vertex" | "cohere" | "copilot" | "bedrock" | "ollama" | string
  provider = "claude",                  -- Recommend using Claude
  auto_suggestions_provider = "claude", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
  ---@alias Tokenizer "tiktoken" | "hf"
  -- Used for counting tokens and encoding text.
  -- By default, we will use tiktoken.
  -- For most providers that we support we will determine this automatically.
  -- If you wish to use a given implementation, then you can override it here.
  tokenizer = "tiktoken",
  ---@type AvanteSupportedProvider
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-7-sonnet-20250219",
    timeout = 30000, -- Timeout in milliseconds
    temperature = 0,
    max_tokens = 20480,
  },
  behaviour = {
    auto_suggestions = false, -- Experimental stage
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = false,
  },
  rag_service = {
    enabled = true,                                 -- Enables the RAG service
    host_mount = "/Users/jasonmason/dev/ui-design", -- Host mount path (your home directory)
    provider = "ollama",                            -- Using Ollama as the provider
    llm_model = "llama3.2",                         -- The LLM model to use (llama3.2 is a good choice for RAG)
    embed_model = "nomic-embed-text",               -- The default embedding model for Ollama
    endpoint = "http://localhost:11434",            -- Ollama's default endpoint
  },
  --- @class AvanteFileSelectorConfig
  file_selector = {
    --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string | fun(params: avante.file_selector.IParams|nil): nil
    provider = "telescope",
    -- Options override for custom providers
    provider_opts = {},
  },
  mappings = {
    --- @class AvanteConflictMappings
    diff = {
      ours = "co",
      theirs = "ct",
      all_theirs = "ca",
      both = "cb",
      cursor = "cc",
      next = "]x",
      prev = "[x",
    },
    suggestion = {
      accept = "<M-l>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-s>",
    },
    sidebar = {
      switch_windows = "<Tab>",
      reverse_switch_windows = "<S-Tab>",
    },
  },
  hints = { enabled = true },
  -- windows = {
  --   ---@type "right" | "left" | "top" | "bottom"
  --   position = "bottom", -- the position of the sidebar
  --   height = 50,
  --   wrap = true,         -- similar to vim.o.wrap
  --   sidebar_header = {
  --     align = "left",    -- left, center, right for title
  --     rounded = false,
  --   },
  -- },
  highlights = {
    --- @type AvanteConflictHighlights
    diff = {
      current = "DiffText",
      incoming = "DiffAdd",
    },
  },
  --- @class AvanteConflictUserConfig
  diff = {
    autojump = true,
    ---@type string | fun(): any
    list_opener = "copen",
  },
})
