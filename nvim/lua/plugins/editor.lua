--
-- Enhancements to core editor functionality
--

return {
  {
    -- Jump to last position on file open
    'farmergreg/vim-lastplace'
  },
  {
    -- Manipulate surrounding pairs of quotes or paranthesis
    'kylechui/nvim-surround',
    version = '^4.0.0'
  },
  {
    -- Highlight jumpable characters
    -- TODO: look at replacing with https://github.com/folke/snacks.nvim/blob/main/docs/scope.md
    'unblevable/quick-scope',
     init = function()
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end
  },
  {
    -- Highlight matching % boundary
    'andymass/vim-matchup',
    event = { 'CursorMoved' },
    config = function()
      vim.g.matchup_matchparen_offscreen = {}
    end
  },
  {
    -- Adds camel and snake case aware motions
    -- TODO: look at replacing with treesitter text-objects
    'bkad/CamelCaseMotion',
    config = function()
      vim.api.nvim_set_keymap('', 'e', '<Plug>CamelCaseMotion_w', { silent = true })
      vim.api.nvim_del_keymap('s', 'e')
      vim.api.nvim_set_keymap('', 'E', '<Plug>CamelCaseMotion_b', { silent = true })
      vim.api.nvim_del_keymap('s', 'E')
    end
  }
}
