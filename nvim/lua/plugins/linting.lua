return {
  {
    "nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lint").linters_by_ft = {
        -- typescript = {"eslint"},
        -- javascript = {"eslint"},
        python = {"mypy"}
      }
      
      vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
        callback = function()
          require("lint").try_lint(nil, { ignore_errors = true })
        end
      })
    end
  },
}
