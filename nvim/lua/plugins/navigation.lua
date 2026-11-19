--
-- Project navigation and searching
--

return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<C-P>",
        function()
          Snacks.picker.files()
        end,
        desc = "Find files"
      },
      {
        "<Leader>g",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep"
      },
      {
        "<Leader>f",
        function()
          Snacks.picker.lines()
        end,
        desc = "Search current buffer"
      },
      {
        ";",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers"
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "References"
      },
      {
        "gi",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Implementations"
      },
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Definitions"
      },
      {
        "gt",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Type definitions"
      },
      {
        "<C-n>",
        function()
          Snacks.explorer()
        end,
        desc = "Toggle file explorer"
      },
      {
        "<C-f>",
        function()
          Snacks.explorer.reveal()
        end,
        desc = "Reveal current file in explorer"
      }
    },
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
            ignored = true,
            exclude = { "dist", "build", "node_modules", ".git" }
          },
          explorer = {
            layout = {
              preset = "default",
              preview = false,
              hidden = { "input" }
            },
            formatters = {
              file = {
                icon_width = 2,
                git_status_hl = true,
                truncate = "left"
              },
            },
            jump = { close = true },
            hidden = true,
            ignored = true,
            exclude = { ".git" },
            diagnostics = false,
            watch = true,
            git_status = true
          }
        }
      }
    }
  },
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      {
        "<Leader>q",
        function()
          require("grug-far").toggle_instance({ instanceName = "far", staticTitle = "Find and Replace" })
        end,
        desc = "Toggle find and replace"
      }
    },
    opts = {}
  }
}
