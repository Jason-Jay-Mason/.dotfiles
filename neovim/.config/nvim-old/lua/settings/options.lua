local opt = vim.opt
local g = vim.g

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

--Gui
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.ruler = false
opt.showcmd = true
opt.cursorline = false -- Highlight the current lineop
opt.scrolloff = 10 -- We want ten empty lines at the bottom of the file
opt.signcolumn = "yes" -- Provide room on the left for sings
opt.laststatus = 2 -- always show the status bar
opt.shortmess = opt.shortmess
	+ {
		c = true, -- Do not show completion messages in command line
		F = true, -- Do not show file info when editing a file, in the command line
		W = true, -- Do not show "written" in command line when writing
		I = true, -- Do not show intro message when starting Vim
	}
opt.cmdheight = 0 -- Set the command height to -0 for more screen real estate
opt.helpheight = 0 -- Make the help windows open full screen

--Text
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2
opt.wrap = false -- Make the text not wrap on small screens

--Functionaility
opt.clipboard = "unnamedplus" -- Copy to system clipboard
opt.mouse = "" -- Enable the mouse
opt.undofile = true -- Enable saving undo history to a file so we can undo files between nvim exits
opt.undodir = os.getenv("HOME") .. "/.nvim/undo" -- Set the undo directory
opt.foldmethod = "marker" -- We want vs code style document folding
opt.foldmarker = "#region,#endregion"
opt.shell = "fish"
opt.updatetime = 750 -- Makes vim more snappy I guess

--Search
opt.hlsearch = false -- Don't highlight every word that matches a search
opt.incsearch = true -- Incrimental searching
opt.ignorecase = true --Ignore the letter case when searching
opt.smartcase = true
