return {
  {
    'stevearc/conform.nvim',
    config = function()
      local webfmt = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true }

      require('conform').setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          go = { 'gofmt' },
          sql = { 'sql_formatter' },
          javascript = webfmt,
          javascriptreact = webfmt,
          typescript = webfmt,
          typescriptreact = webfmt,
          yaml = webfmt,
          css = webfmt,
          html = webfmt
        },
        formatters = {
          sql_formatter = {
            prepend_args = { '--language', 'postgresql' }
          }
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = 'fallback'
        }
      })
    end
  }
}
