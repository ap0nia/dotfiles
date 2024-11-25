return {
  -- Load the main LSP plugin.
  'neovim/nvim-lspconfig',

  dependencies = {
    -- Package manager for LSP integrations.
    'williamboman/mason.nvim',

    -- Bridge between mason.nvim and lspconfig. i.e. Can ensure LSPs are installed automatically.
    'williamboman/mason-lspconfig.nvim',
  },

  config = function()
    require('config.lsp').setup()
  end
}
