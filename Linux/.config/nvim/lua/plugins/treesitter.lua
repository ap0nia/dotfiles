-- Whether a buffer is considered a large. This is used to disable treesitter for large files.
local function is_large_buffer(_, bufnr)
  return vim.api.nvim_buf_line_count(bufnr) > 20000
end

return {
  "nvim-treesitter/nvim-treesitter",

  build = ":TSUpdate",

  config = function () 
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "jsdoc",
        "typescript",
        "svelte"
      },
      sync_install = false,
      highlight = {
        enable = true,
        disable = is_large_buffer
      },
      indent = {
        enable = true,
        disable = is_large_buffer
      },
    })
  end
}
