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
    opts = {
      highlight = {
        enable = true
      },
      indent = {
        enable = true
      }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
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
        lualine_b = {"branch"},
        lualine_c = {
          {
            "filename",
            file_status = true,
            full_path = true
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
            sources = {"nvim_lsp"}
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
      { "<C-n>", ":NvimTreeToggle<CR>", noremap = true }
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
    "nvim-telescope/telescope.nvim", tag = "0.1.1",
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
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        debug = true,
        root_dir = require("null-ls.utils").root_pattern(
          "package.json",
          "Pipfile",
          "requirements.txt",
          ".git"
        ),
        sources = {
          -- js
          null_ls.builtins.diagnostics.tsc,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.formatting.prettierd,
          -- python
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.formatting.autopep8,
          null_ls.builtins.formatting.autoflake,
          -- misc
          -- null_ls.builtins.diagnostics.actionlint,
          -- null_ls.builtins.diagnostics.cfn_lint,
          -- null_ls.builtins.diagnostics.shellcheck,
          -- null_ls.builtins.diagnostics.stylelint,
          -- null_ls.builtins.diagnostics.terraform_validate,
          -- null_ls.builtins.diagnostics.yamllint
        },
        on_attach = function(client, bufnr)
          local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  filter = function(client)
                    -- only format with null-ls
                    return client.name == "null-ls"
                  end,
                  bufnr = bufnr
                })
              end
            })
          end
        end
      }
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
              { name = "nvim_lsp" }
            },
            mapping = {
              ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
              ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
              ["<Tab>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
              ["<Enter>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
              ["<Esc>"] = cmp.mapping.close()
            }
          }
        end
      },
      "hrsh7th/cmp-nvim-lsp",
      "mfussenegger/nvim-dap"
    },
    opts = {
      diagnostics = {
        underline = true,
        signs = true,
        update_in_insert = false,
        virtual_text = false, -- { spacing = 4, prefix = "●" },
        severity_sort = true
      },
      servers = {
        "tsserver",
        "pyright"
      },
      signs = { Error = " ", Warn = " ", Hint = "", Info = " " }
    },
    config = function(_, opts)
      -- TODO setup DAP

      -- diagnostic config
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

      -- setup servers
      for k, server in pairs(opts.servers) do
        require("lspconfig")[server].setup({
          capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
          on_attach = function(client, buff)
            vim.api.nvim_buf_set_keymap(buff or 0, "n", "K", ":lua vim.lsp.buf.hover()<CR>", { silent = true })
            vim.api.nvim_buf_set_keymap(buff or 0, "n", "<Leader>a", ":lua vim.diagnostic.open_float()<CR>", { silent = true })
          end
        })
      end
    end
  }
}, lazyopts)
