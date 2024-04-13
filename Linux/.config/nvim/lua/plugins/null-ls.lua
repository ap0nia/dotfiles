local function format()
  vim.lsp.buf.format({ async = false })
end

return {
  'jose-elias-alvarez/null-ls.nvim',

  opts = function()
    local null_ls = require('null-ls')

    return {
      sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.black
      },

      on_attach = function(client)
        if client.supports_method("textDocument/formatting") then
          vim.keymap.set('n', '<leader>f', format, { noremap = true, silent = true })
        end
      end
    }
  end
}
