local M = {}

function M.setup()
  -- Set the leader key to spacebar.
  vim.g.mapleader = ' '

  -- Enable 24-bit RGB color.
  vim.opt.termguicolors = true

  -- A TAB character looks like 4 spaces.
  vim.opt.tabstop = 4

  -- Pressing the TAB key will insert spaces instead of a TAB character.
  vim.opt.expandtab = true

  -- Number of spaces inserted instead of a TAB character.
  vim.opt.softtabstop = 4

  -- Number of spaces inserted when indenting.
  vim.opt.shiftwidth = 2

  -- Automatically indent a new line to the same number of spaces as the previous line.
  vim.opt.autoindent = true

  -- Show line numbers.
  vim.opt.number = true

  -- Show relative line numbers.
  -- Toggling both `number` and `relativenumber` produces a hybrid result:
  -- the current line displays the absolute (real) line number, 
  -- all lines above/below the current line display the relative line number.
  vim.opt.relativenumber = true

  -- Don't wrap lines that overflow the buffer.
  vim.opt.wrap = false

  vim.opt.colorcolumn = '90'

  vim.filetype.add {
	filename = {
		['Jenkinsfile'] = 'groovy'
	}
  }
end

return M
