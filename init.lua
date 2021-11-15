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

--
-- key mappings
--

vim.api.nvim_set_keymap("n", "<Esc>", ":noh<Return><Esc>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-d>", ":%bd|e#|bd#<CR>", {})
vim.api.nvim_set_keymap("n", "<Leader>r", ":e ~/dotfiles/init.lua<Return>", { noremap = true })
vim.api.nvim_set_keymap("n", "<Leader>s", ":e ~/Desktop/scratchpad.md<Return>", {})

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
      vim.g.onedark_darker_diagnostics = false
      require('onedark').setup()
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
          -- TODO is this working OK?
          enable = true
        }
      })
    end
  }
  use {
    "nvim-lualine/lualine.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("lualine").setup({
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
            "diagnostics",
            sources = {"nvim_lsp"}
          }
        }
      })
    end
  }
  use {
    "lewis6991/gitsigns.nvim",
    requires = "plenary.nvim",
    config = function()
      require('gitsigns').setup({
        signs = {
          delete = {text = '│'},
          topdelete = {text = '│'},
          changedelete = {text = '│'}
        }
      })
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    after = 'nvim-web-devicons',
    setup = function()
      local km = vim.api.nvim_set_keymap
      km("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true })
      vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
      vim.g.nvim_tree_gitignore = 0
      vim.g.nvim_tree_quit_on_open = 1
      vim.g.nvim_tree_indent_markers = 1
      vim.g.nvim_tree_special_files = {}
      vim.g.nvim_tree_show_icons = {
				git = 0,
        folders = 0,
        files = 0,
        folder_arrows = 0,
      }
    end,
    config = function()
      require("nvim-tree").setup({
        auto_close = false,
        diagnostics = {
          enable = false
        }
      })
    end
  }

  --
  -- utils
  --
  use "farmergreg/vim-lastplace"
  use {
    "tpope/vim-surround",
    config = function()
      vim.api.nvim_set_keymap("n", "<C-s>", "ysiw", {})
    end
  }
  use {
    "unblevable/quick-scope",
    config = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end
  }
  use {
    "terrortylor/nvim-comment",
    cmd = "CommentToggle",
    setup = function()
      vim.api.nvim_set_keymap("", "<Leader>cc", ":CommentToggle<CR>", {noremap = true})
    end,
    config = function()
      require('nvim_comment').setup({
        comment_empty = false,
        line_mapping = 'gcc'
      })
    end
  }
  use {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end
  }
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup()
    end
  }
  use {
    "bkad/CamelCaseMotion",
    config = function()
      vim.api.nvim_set_keymap("", "e", "<Plug>CamelCaseMotion_e", { silent = true })
      vim.api.nvim_del_keymap("s", "e")
    end
  }

  --
  -- Fuzzy finder
  --
  use {
    "ibhagwan/fzf-lua",
    requires = { "vijaymarupudi/nvim-fzf" },
    setup = function()
      local km = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      km("n", "<C-P>", "<cmd>lua require('fzf-lua').files({ cmd = \"rg --files --hidden --color=never -g '!.git/**'\"})<CR>", opts)
      km("n", "<Leader>g", "<cmd>lua require('fzf-lua').grep_visual()<CR>", opts)
      km("n", "<Leader>t", "<cmd>lua require('fzf-lua').lsp_typedefs()<CR>", opts)
      km("n", ";", "<cmd>lua require('fzf-lua').buffers()<CR>", opts)
    end,
    config = function()
      require('fzf-lua').setup({
        preview = {
          layout = 'vertical'
        },
        buffers = {
          git_icons = false
        },
        files = {
          git_icons = false,
          file_icons = false
        },
        grep = {
          git_icons = false,
          file_icons = false
        }
      })
    end
  }

  --
  -- LSP
  --
  use {
    "ms-jpq/coq_nvim",
    branch = "coq"
  }
  use {
    "neovim/nvim-lspconfig",
    config = function()
      local nvim_lsp = require("lspconfig")

      local on_attach = function(client, bufnr)
        local buf_map = vim.api.nvim_buf_set_keymap
        local opts = { silent = true }
        vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
        vim.cmd('COQnow -s')

        buf_map(bufnr, "n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts)
        buf_map(bufnr, "n", "gR", ":lua vim.lsp.buf.references()<CR>", opts)
        buf_map(bufnr, "n", "K", ":lua vim.lsp.buf.hover()<CR>", opts)
        buf_map(bufnr, "n", "<Leader>a", ":lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
        buf_map(bufnr, "n", "gf", ":lua vim.lsp.buf.formatting()<CR>", opts)
        buf_map(bufnr, "n", "gl", ":lua vim.lsp.buf.implementation()<CR>", opts)

        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_exec([[
           augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> LspFormatting
           augroup END
           ]], true)
        end
      end

      -- do formatting async for improved performance
      local format_async = function(err, _, result, _, bufnr)
        if err ~= nil or result == nil then return end
        if not vim.api.nvim_buf_get_option(bufnr, "modified") then
          local view = vim.fn.winsaveview()
          vim.lsp.util.apply_text_edits(result, bufnr)
          vim.fn.winrestview(view)
          if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
          end
        end
      end
      vim.lsp.handlers["textDocument/formatting"] = format_async

      -- Typescript lang server
      nvim_lsp.tsserver.setup({
        on_attach = function(client)
          client.resolved_capabilities.document_formatting = false
          on_attach(client)
        end
      })

      -- Diagnostic display settings
      local signs = { Error = " ", Warning = " ", Hint = "", Information = " " }
      for type, icon in pairs(signs) do
         local hl = "LspDiagnosticsSign" .. type
         vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        underline = true,
        update_in_insert = false
      })
      vim.o.updatetime = 750
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})]]

      -- TODO add CSS lsp

      -- Linting and Formatting
      nvim_lsp.diagnosticls.setup {
        on_attach = function(client)
          client.resolved_capabilities.document_formatting = true
          on_attach(client)
        end,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        init_options = {
          linters = {
            eslint = {
              sourceName = "eslint",
              command = "eslint_d",
              rootPatterns = {".eslintrc.js", ".eslintrc", "package.json"},
              debounce = 100,
              args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
              parseJson = {
                errorsRoot = "[0].messages",
                line = "line",
                column = "column",
                endLine = "endLine",
                endColumn = "endColumn",
                message = "${message} [${ruleId}]",
                security = "severity"
              },
              securities = {[2] = "error", [1] = "warning"}
            }
          },
          formatters = {
            prettier = {
              command = "prettier",
              rootPatterns = {".prettierrc.js", ".prettierrc", "package.json"},
              args = {"--stdin-filepath", "%filepath"}
            }
          },
          filetypes = {
            typescript = "eslint",
            typescriptreact = "eslint",
            javascript = "eslint",
            javascriptreact = "eslint",
          },
          formatFiletypes = {
            typescript = "prettier",
            typescriptreact = "prettier",
            javascript = "prettier",
            javascriptreact = "prettier"
          }
        }
      }
    end
  }
end)
