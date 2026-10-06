return {
  -- TODO: look at replacing a lot of this with a unified set of plugins based on Snacks.nvim
  -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
  -- https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md
  -- plus...
  -- https://github.com/folke/snacks.nvim/blob/main/docs/dim.md
  -- https://github.com/folke/snacks.nvim/blob/main/docs/image.md
  -- https://github.com/folke/snacks.nvim/blob/main/docs/words.md
  {
    "nvim-telescope/telescope.nvim", branch = "master",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-P>",     ":Telescope find_files<CR>" },
      { "<Leader>g", ":Telescope live_grep<CR>" },
      { "<Leader>f", ":Telescope current_buffer_fuzzy_find<CR>" },
      { ";",         ":Telescope buffers<CR>" },
      { "gr",        ":Telescope lsp_references<CR>" },
      { "gi",        ":Telescope lsp_implementations<CR>" },
      { "gd",        ":Telescope lsp_definitions<CR>" },
      { "gt",        ":Telescope lsp_type_definitions<CR>" }
    },
    opts = {}
  },
  {
    "kyazdani42/nvim-tree.lua",
    keys = {
      { "<C-n>", ":NvimTreeToggle<CR>", noremap = true },
      { "<C-f>", ":NvimTreeFindFile<CR>", noremap = true }
    },
    opts = {
      update_focused_file = {
        enable = true
      },
      actions = {
        open_file = {
          quit_on_open = true
        }
      },
      renderer = {
        icons = {
          show = {
            git = false,
            folder = false,
            file = false,
            folder_arrow = false
          }
        },
        indent_markers = {
          enable = true
        },
        special_files = {}
      },
      diagnostics = {
        enable = false
      },
      git = {
        ignore = false
      },
      filters = {
        dotfiles = false,
        custom = { "node_modules", ".git/" }
      }
    }
  },
  {
    'nvim-pack/nvim-spectre',
    keys = {
       {'<Leader>q', '<cmd>lua require("spectre").toggle()<cr>', mode={'n'}}
    },
    config = function()
       require('spectre').setup({ is_block_ui_break = true })
    end
  }
}
