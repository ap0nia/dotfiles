return {
  'hrsh7th/nvim-cmp',

  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind.nvim',
  },

  config = function()
    require('config.completion').setup()
  end
}
