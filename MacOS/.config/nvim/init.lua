vim.filetype.add({
  extension = {
    mdx = 'mdx'
  }
})

local function ensure_lazy_installed()
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end

  if not vim.tbl_contains(vim.opt.rtp:get(), lazypath) then
    vim.opt.rtp:prepend(lazypath)
  end
end

local function init()
  require('config').setup()

  ensure_lazy_installed()

  require('lazy').setup('plugins')
end

init()
