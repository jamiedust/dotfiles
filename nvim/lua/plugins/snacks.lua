return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<C-d>',
      function()
        Snacks.bufdelete.other()
      end,
      desc = 'Delete other buffers'
    },
    {
      '<leader>z',
      function()
        if Snacks.dim.enabled then Snacks.dim.disable() else Snacks.dim.enable() end
      end,
      desc = 'Toggle code dim'
    },
    {
      ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        mode = { 'n', 't' },
        desc = 'Next reference'
      },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      mode = { 'n', 't' },
      desc = 'Previous reference'
    }
  },
  opts = {
    bufdelete = { enabled = true },
    words = { enabled = true },
    image = { enabled = true },
  }
}
