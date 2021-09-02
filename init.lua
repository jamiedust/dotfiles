--
-- options
--
vim.cmd("syntax on")
vim.o.backup = true
vim.o.backupdir = "/private/tmp"
vim.o.dir = "/private/tmp"
vim.o.backspace = "indent,eol,start"
vim.o.ruler = true
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.linebreak = true
vim.o.smartindent = true
vim.o.cindent = true
vim.o.autoindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cursorline = true
-- vim.o.cursorcolumn = true
vim.o.hidden = true
vim.o.clipboard = "unnamed"
-- vim.o.wcm = <tab> 
vim.o.shortmess = "a"
vim.o.termguicolors = true

local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Don't show status line on certain windows
-- vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber ]]
-- vim.cmd [[let hidden_statusline = luaeval('require("chadrc").ui.hidden_statusline') | autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter,TermEnter * nested if index(hidden_statusline, &ft) >= 0 | set laststatus=0 | else | set laststatus=2 | endif]]

--
-- key mappings
--

local set_keymap = vim.api.nvim_set_keymap
local del_keymap = vim.api.nvim_del_keymap

-- nvim_set_keymap('n' ',', 'i_<Esc>r', { noremap = true })
set_keymap("n", "<Esc>", ":noh<Return><Esc>", { noremap = true })
set_keymap("n", "<C-d>", ":%bd|e#|bd#<CR>", {})
set_keymap("n", "<Leader>r", ":e ~/dotfiles/init.lua<Return>", { noremap = true })
set_keymap("n", "<Leader>s", ":e ~/Desktop/scratchpad.md<Return>", {})

--
-- plugins
--
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function()
  --
  -- core
  --
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim"
  use "nvim-lua/popup.nvim"

  --
  -- ui
  --
  use {
    "navarasu/onedark.nvim",
    config = function()
      vim.cmd[[colorscheme onedark]]
    end
  }
  use {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require('nvim-web-devicons').setup({ default = true })
    end
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true
        },
        indent = {
          enable = true,
        }
      })
    end
  }
  use {
    "hoob3rt/lualine.nvim",
    after = "nvim-web-devicons",
    config = function()
      require('lualine').setup({
        options = {
          theme = 'onedark'
        }
      })
    end
  }
  use {
    "akinsho/nvim-bufferline.lua",
    after = "nvim-web-devicons",
    config = function()
      -- TODO sort config
      require("bufferline").setup({
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        diagnostics = "nvim_lsp"
      })
    end
  }
  use {
    "lewis6991/gitsigns.nvim",
    after = "plenary.nvim",
    config = function()
      -- TODO get working
      require('gitsigns').setup()
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    after = 'nvim-web-devicons',
    setup = function()
      local km = vim.api.nvim_set_keymap
      km("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })
      vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
      vim.g.nvim_tree_gitignore = 1
      vim.g.nvim_tree_auto_close = 1
      vim.g.nvim_tree_quit_on_open = 1
      vim.g.nvim_tree_indent_markers = 1
    end
  }

  --
  -- utils
  --
  use "farmergreg/vim-lastplace"
  --use {
   -- "tpope/vim-surround",
    --config = function()
     -- -- TODO fix
     -- set_keymap("n", "<C-s>", "ysiw", {})
   -- end
 -- }
  use {
    "unblevable/quick-scope",
    config = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end
  }
  use {
    "terrortylor/nvim-comment",
    cmd = "CommentToggle",
    config = function()
      -- TODO fux
      require('nvim_comment').setup({ comment_empty = false })
    end
  }
  use {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end
  }
  -- use {
  --  "bkad/CamelCaseMotion",
   -- config = function()
    --  del_keymap("n", "e")
     -- set_keymap("n", "e", "<Plug>CamelCaseMotion_e", { silent = true })
    --end
 -- }

  --
  -- Fuzzy finder
  --
  use "nvim-telescope/telescope-media-files.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use {
    "nvim-telescope/telescope.nvim",
    after = { "popup.nvim", "plenary.nvim", "telescope-media-files.nvim" },
    cmd = "Telescope",
    opt = false,
    setup = function()
      local km = vim.api.nvim_set_keymap
      km("n", "<C-p>", ":Telescope find_files<CR>", {})
      km("n", "<Leader>g", ":Telescope live_grep<CR>", {})
      km("n", ";", ":Telescope buffers<CR>", {})
    end,
    config = function()
      -- TODO look into ripgrep and fzf
      require('telescope').setup({
       defaults = {
          vimgrep_arguments = {
             "rg",
             "--color=never",
             "--no-heading",
             "--with-filename",
             "--line-number",
             "--column",
             "--smart-case"
          },
          extensions = {
            media_files = {
               filetypes = { "png", "webp", "jpg", "jpeg" },
               find_cmd = "rg"
            },
            fzf = {
              fuzzy = true,                    -- false will only do exact matching
              override_generic_sorter = true, -- override the generic sorter
              override_file_sorter = true,     -- override the file sorter
              case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            }
          }
        }
      })
      require("telescope").load_extension("media_files")
      require("telescope").load_extension("fzf")
    end
  }

  --
  -- LSP
  --
end)
