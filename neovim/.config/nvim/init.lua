--Speed up loading Lua modules in Neovim to improve startup time.
pcall(require, 'impatient')

require('utils').ensure_packer()

require 'settings'

require 'plugins'

-- Load the config for LSP zero
require 'plugins.config.lsp-zero'
