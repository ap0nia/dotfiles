return {
  'akinsho/bufferline.nvim',

  dependencies = 'nvim-tree/nvim-web-devicons',

  opts = function()
    return {
      options = {
        separator_style = 'slant',
        mode = 'tabs'
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get()
    }
  end
}
