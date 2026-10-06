--
-- User Interface enhancements
--

return {
  {
    -- Tree-sitter syntax highlighting
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('nvim-treesitter.config').setup({
        ensure_installed = {
          'bash', 'python', 'go', 'comment', 'lua',
          'markdown', 'markdown_inline', 'css', 'html',
          'javascript', 'typescript', 'tsx', 'yaml', 'json'
        },
        highlight = {
          enable = true
        },
        indent = {
          enable = true
        }
      })
    end
  },
  {
    -- One Dark Theme
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      diagnostics = {
        darker = false
      }
    },
    config = function()
      require('onedark').load()
    end
  },
  {
    -- Dev Icons
    'nvim-tree/nvim-web-devicons',
    lazy = true
  },
  {
    -- Highlight CSS colours
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },
  {
    -- Highlight lines with uncommitted changes
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = {text = '│'},
        change = {text = '│'},
        delete = {text = '│'},
        topdelete = {text = '│'},
        changedelete = {text = '│'}
      }
    }
  },
  {
    -- Help remember keybinds
    -- TODO: use which-key to manage keybinds
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = {
        marks = false,
        registers = false,
        presets = {
          operators = false,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true
        }
      }
    }
  },
  {
    -- Statusline component
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'onedark',
        component_separators = {left = '', right = ''}
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 3
          }
        },
        lualine_x = {'encoding', 'fileformat'},
        lualine_y = {'filetype'},
        lualine_z = {'location'}
      },
      tabline = {
        lualine_a = {'buffers'},
        lualine_x = {
          {
            'diagnostics',
            sources = {'nvim_lsp', 'nvim_diagnostic'},
            update_in_insert = true
          }
        }
      }
    }
  }
}
