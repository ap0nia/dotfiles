return {
  "nvim-neo-tree/neo-tree.nvim",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  config = function()
    require('neo-tree').setup({ })
    vim.keymap.set('n', '|', '<cmd>Neotree toggle<CR>', { silent = true })
  end
}
