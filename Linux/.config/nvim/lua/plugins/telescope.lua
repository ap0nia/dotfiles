return {
  'nvim-telescope/telescope.nvim',

  branch = '0.1.x',

  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    require('telescope').setup({})

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>t', builtin.find_files, {})
  end
}
