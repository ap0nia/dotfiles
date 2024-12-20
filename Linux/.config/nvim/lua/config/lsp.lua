local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')

-- Setup the plugins.
local function setup_plugins()
  mason.setup()
  mason_lspconfig.setup()
end

-- Setup basic LSP behaviors.
local function setup_behaviors()
  local opts = { noremap = true, silent = true }

  -- Force open the error popup.
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)

  -- Open the error popup after hovering for 250ms.
  vim.opt.updatetime = 250
  vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

  -- Go to next/previous errors.
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

  -- Open all errors in file.
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end

-- Setup LSP servers.
local function setup_servers()
  local function list_workspace()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end

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
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', list_workspace, bufopts)

    -- Rename a variable throughout the file.
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)

    -- Show code actions, e.g. "quick fixes".
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  end

  -- Get the default LSP capabilities for Nvim's LSP client.
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Extend the capabilities with completion.
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  local lspSettings = {
    jsonls = {
      settings = {
        json = {
          schemas = {
            {
              description = 'TypeScript compiler configuration file',
              fileMatch = {'tsconfig.json', 'tsconfig.*.json'},
              url = 'http://json.schemastore.org/tsconfig'
            },
            {
              description = 'Node.js package.json file',
              fileMatch = {'package.json'},
              url = 'https://json.schemastore.org/package.json'
            },
          }
        }
      }
    },
    mdx_analyzer = {
      filetypes= {
        "mdx"
      },
      settings = {
        mdx = {
          trace = {
            server = {
              verbosity = "verbose",
            }
          }
        }
      }
    },
    vtsls = {
      settings = {
        vtsls = {
          autoUseWorkspaceTsdk = true,
          tsserver = {
            globalPlugins = {
              {
                name = '@mdx-js/typescript-plugin',
                languages = { 'mdx' }
              }
            }
          }
        }
      },
      filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
        'mdx',
      },
    },
  }

  -- Configure each LSP with completion capababilities, e.g. autocomplete,
  -- and all the buffer attach settings, e.g. hover and show go to definition.
  -- See :help lspconfig-setup
  local default_handler = function(server)
    local options = lspSettings[server] or {}
    options.capabilities = capabilities
    options.on_attach = on_attach
    lspconfig[server].setup(options)
  end

  -- See :help mason-lspconfig-dynamic-server-setup
  mason_lspconfig.setup_handlers({ default_handler })
end

local M = {}

function M.setup()
  setup_plugins()
  setup_behaviors()
  setup_servers()
end

return M
