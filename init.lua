-- init.lua

-- Base options
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
vim.o.hidden = true
vim.o.clipboard = "unnamed"
vim.o.shortmess = "a"
vim.o.termguicolors = true
vim.o.completeopt = "menu,menuone,noselect,noinsert"

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

-- Base mappings
vim.api.nvim_set_keymap("n", "<Esc>", ":noh<Return><Esc>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-d>", ":%bd|e#|bd#<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>i", ":e ~/dotfiles/init.lua<Return>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>s", ":e ~/Desktop/scratchpad.md<Return>", {})

-- custom filetypes
vim.filetype.add({
  pattern = {
    [".*/.github/workflows/.*%.yml"] = "yaml.ghaction"
  }
})

-- Init Lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

local lazyopts = {
  lockfile = "~/dotfiles/lazy-lock.json"
}

lazy.setup({
  {
    "navarasu/onedark.nvim",
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
    "nvim-tree/nvim-web-devicons",
    lazy = true
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
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
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "onedark",
        component_separators = {left = "", right = ""},
      },
      sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff"},
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 3
          }
        },
        lualine_x = {"encoding", "fileformat"},
        lualine_y = {"filetype"},
        lualine_z = {"location"}
      },
      tabline = {
        lualine_a = {"buffers"},
        lualine_x = {
          {
            "diagnostics",
            sources = {"nvim_lsp", "nvim_diagnostic"},
            update_in_insert = true
          }
        }
      }
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = {text = "│"},
        change = {text = "│"},
        delete = {text = "│"},
        topdelete = {text = "│"},
        changedelete = {text = "│"}
      }
    }
  },
  {
    "kyazdani42/nvim-tree.lua",
    keys = {
      { "<C-n>", ":NvimTreeToggle<CR>", noremap = true },
      { "<C-f>", ":NvimTreeFindFile<CR>", noremap = true }
    },
    opts = {
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
        custom = { "node_modules" }
      }
    }
  },
  {
    "farmergreg/vim-lastplace"
  },
  {
    "tpope/vim-surround"
  },
  {
    "unblevable/quick-scope",
    init = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      mappings = {
        extra = false
      }
    }
  },
  {
    "andymass/vim-matchup",
    event = { "CursorMoved" },
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = true
  },
  {
    "bkad/CamelCaseMotion",
    config = function()
      vim.api.nvim_set_keymap("", "e", "<Plug>CamelCaseMotion_e", { silent = true })
      vim.api.nvim_del_keymap("s", "e")
    end
  },
  {
    "nvim-pack/nvim-spectre",
    keys = {
       {"<Leader>q", "<cmd>lua require('spectre').toggle()<cr>", mode={"n"}},
    },
    config = function()
       require("spectre").setup({ is_block_ui_break = true })
    end
  },
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.4",
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
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        -- ghaction = {"actionlint"},
        -- go = {"revive"},
        typescript = {"eslint"},
        javascript = {"eslint"},
        python = {"mypy"}
      }
      vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
        callback = function()
          require("lint").try_lint(nil, { ignore_errors = true })
        end
      })
    end
  },
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup({
        logging = true,
        log_level = vim.log.levels.WARN,
        filetype = {
          javascript = {
            require("formatter.filetypes.javascript").prettierd,
            require("formatter.filetypes.javascript").eslint_d
          },
          typescript = {
            require("formatter.filetypes.typescript").prettierd,
            require("formatter.filetypes.typescript").eslint_d
          },
          python = {
            require("formatter.filetypes.python").autopep8
          },
          ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace
          }
        }
      })

      vim.api.nvim_create_augroup("__formatter__", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = "__formatter__",
        command = ":FormatWrite",
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "hrsh7th/nvim-cmp",
        opts = function()
          local cmp = require("cmp")
          return {
            sources = {
              { name = "nvim_lsp" },
              { name = 'vsnip' }
            },
            snippet = {
              expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
              end,
            },
            mapping = {
              ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
              ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
              ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
              ["<Enter>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
              ["<Esc>"] = cmp.mapping.close()
            }
          }
        end
      },
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "hrsh7th/cmp-nvim-lsp",
      "mfussenegger/nvim-dap",
    },
    opts = {
      diagnostics = {
        underline = true,
        signs = true,
        update_in_insert = false,
        virtual_text = false, -- { spacing = 4, prefix = "●" },
        severity_sort = true
      },
      signs = { Error = " ", Warn = " ", Hint = "", Info = " " }
    },
    config = function(_, opts)
      -- TODO setup DAP

      for type, icon in pairs(opts.signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.diagnostic.config(opts.diagnostics)
      vim.o.updatetime = 750

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        callback = function()
          vim.diagnostic.open_float({ focusable=false })
        end
      })

      -- ts_ls
      vim.lsp.config("ts_ls", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function(client, buff)
          vim.api.nvim_buf_set_keymap(buff or 0, "n", "K", ":lua vim.lsp.buf.hover()<CR>", { silent = true })
          vim.api.nvim_buf_set_keymap(buff or 0, "n", "<Leader>a", ":lua vim.diagnostic.open_float()<CR>", { silent = true })
        end
      })
      vim.lsp.enable("ts_ls")

      -- pyright
      vim.lsp.config("pyright", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function(client, buff)
          vim.api.nvim_buf_set_keymap(buff or 0, "n", "K", ":lua vim.lsp.buf.hover()<CR>", { silent = true })
          vim.api.nvim_buf_set_keymap(buff or 0, "n", "<Leader>a", ":lua vim.diagnostic.open_float()<CR>", { silent = true })
        end
      })
      vim.lsp.enable("pyright")

      -- gopls
      vim.lsp.config("gopls", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function(client, buff)
          vim.api.nvim_buf_set_keymap(buff or 0, "n", "K", ":lua vim.lsp.buf.hover()<CR>", { silent = true })
          vim.api.nvim_buf_set_keymap(buff or 0, "n", "<Leader>a", ":lua vim.diagnostic.open_float()<CR>", { silent = true })
        end
      })
      vim.lsp.enable("gopls")
    end
  }
}, lazyopts)
