return {
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
      "hrsh7th/cmp-nvim-lsp"
    },
    opts = {
      diagnostics = {
        underline = true,
        signs = true,
        update_in_insert = false,
        virtual_text = false,
        severity_sort = true
      },
      signs = { Error = " ", Warn = " ", Hint = "", Info = " " }
    },
    config = function(_, opts)
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

      local default_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local default_on_attach = function(client, buff)
        vim.api.nvim_buf_set_keymap(buff or 0, "n", "K", ":lua vim.lsp.buf.hover()<CR>", { silent = true })
        -- vim.api.nvim_buf_set_keymap(buff or 0, "n", "<Leader>a", ":lua vim.diagnostic.open_float()<CR>", { silent = true })
      end

      vim.lsp.config("ts_ls", { capabilities = default_capabilities, on_attach = default_on_attach })
      vim.lsp.enable("ts_ls")

      vim.lsp.config("eslint", { capabilities = default_capabilities, on_attach = default_on_attach })
      vim.lsp.enable("eslint")

      vim.lsp.config("oxlint", { capabilities = default_capabilities, on_attach = default_on_attach })
      vim.lsp.enable("oxlint")

      vim.lsp.config("pyright", { capabilities = default_capabilities, on_attach = default_on_attach })
      vim.lsp.enable("pyright")

      vim.lsp.config("gopls", { capabilities = default_capabilities, on_attach = default_on_attach })
      vim.lsp.enable("gopls")
    end
  }
}
