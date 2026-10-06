--
-- init.lua
--

-- base settings
local o = vim.o
local opt = vim.opt

o.backup = true
o.backupdir = '/private/tmp'
o.dir = '/private/tmp'

o.backspace = 'indent,eol,start'

o.tabstop = 2
o.shiftwidth = 2
o.smarttab = true
o.expandtab = true

o.autoindent = true
o.smartindent = true
o.cindent = true

o.ignorecase = true
o.smartcase = true

o.ruler = true
o.cursorline = true
o.linebreak = true
o.number = true
o.relativenumber = true
o.termguicolors = true
o.completeopt = 'menu,menuone,preview,noselect,noinsert,fuzzy,nosort'

opt.shortmess:append 'a'

o.splitright = true
o.splitbelow = true

o.hidden = true
o.clipboard = 'unnamed'

-- disabled built-ins
local g = vim.g

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- key maps
local map = vim.api.nvim_set_keymap
-- TODO: look into https://github.com/folke/snacks.nvim/blob/main/docs/keymap.md

-- TODO: consider replacing with - https://github.com/folke/snacks.nvim/blob/main/docs/bufdelete.md
map('n', '<C-d>', ':%bd|e#|bd#<CR>', { desc = 'Delete all buffers except current' })

map('n', '<Leader>n', ':Telescope find_files search_dirs={"~/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents/Obsidian"}<Return>', { desc = 'Open a file in notes directory' })

--
-- Init Lazy.nvim package manager
-- TODO: move to nvim native package manager
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

local lazyopts = {
  lockfile = "~/dotfiles/nvim/lazy-lock.json"
}

lazy.setup("plugins", lazyopts)
