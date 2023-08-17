return {
  {
    'catppuccin/nvim',

    config = function()
      -- Load the colorscheme.
      vim.cmd.colorscheme "catppuccin-mocha"

      -- Enable transparency. Useful if e.g. terminal is also transparent.
      vim.cmd.hi "Normal guibg=NONE ctermbg=NONE"
    end
  }
}
