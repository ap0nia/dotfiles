return {
  {
    'nvim-lualine/lualine.nvim',

    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },

    opts = function()
      return {
        options = {
          theme = 'catppuccin'
        }
      }
    end
  }
}
