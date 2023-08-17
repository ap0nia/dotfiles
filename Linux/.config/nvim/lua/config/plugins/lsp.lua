local mason = require('mason')
local masonLspConfig = require('mason-lspconfig')

-- Setup the plugins.
local function setup_plugins()
  mason.setup()

  masonLspConfig.setup({
    ensure_installed = {
      'tsserver',
      'svelte',
      'volar',
      'jsonls',
    },
    automatic_installation = true,
  })
end

-- Setup basic LSP behaviors.
local function setup_behaviors()
  local opts = { noremap = true, silent = true }

  -- Force open the error popup.
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

  -- Open the error popup after hovering for 250ms.
  vim.o.updatetime = 250
  vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

  -- Go to next/previous errors.
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

  -- Open all errors in file.
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end

-- Setup LSP servers.
local function setup_servers()
  -- Use an `on_attach` function to only map the following keys
  -- after the language server attaches to the current buffer.
  local on_attach = function(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    -- Go to declaration.
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)

    -- Go to the type definition.
    vim.keymap.set('n', 'gk', vim.lsp.buf.type_definition, bufopts)

    -- Go to definition.
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)

    -- Go to implemention, seems like the same thing as definition.
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)

    -- Show places where the variable is referenced in the current file.
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

    -- Trigger hovering, e.g. in VSCode you can get TypeScript information by hovering.
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

    -- Probably something similar to hovering.
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

    -- Workspace management, idk what workspaces are for.
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)

    -- Rename a variable throughout the file.
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)

    -- Show code actions, e.g. "quick fixes".
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)

    -- Format the file
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end

  -- Get the default LSP capabilities for Nvim's LSP client.
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Extend the capabilities with completion.
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Pre-defined configurations for various language servers.
  local lspconfig = require('lspconfig')

  -- Configure each LSP with completion capababilities, e.g. autocomplete,
  -- and all the buffer attach settings, e.g. hover and show go to definition.
  -- See :help lspconfig-setup
  local default_handler = function(server)
    lspconfig[server].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end

  -- See :help mason-lspconfig-dynamic-server-setup
  masonLspConfig.setup_handlers({
    default_handler,
  })
end


local M = {}

-- Setup Neovim LSP and Mason.
function M.setup()
  setup_plugins()
  setup_behaviors()
  setup_servers()
end

return M
