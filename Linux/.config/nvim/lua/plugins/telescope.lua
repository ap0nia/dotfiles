return {
  'nvim-telescope/telescope.nvim',

  branch = '0.1.x',

  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    require('telescope').setup({})

    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>tf', builtin.find_files, {})
    vim.keymap.set('n', '<leader>tg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>th', builtin.help_tags, {})
  end
}
