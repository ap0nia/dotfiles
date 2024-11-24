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
    local lspconfig = require('lspconfig')
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local neodev = require('neodev')

    -- Setup the plugins.
    local function setup_plugins()
      neodev.setup()

      mason.setup()

      mason_lspconfig.setup({
        ensure_installed = { },
        automatic_installation = false,
      })
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
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)

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
        vtsls = {
          settings = {
            vtsls = {
              autoUseWorkspaceTsdk = true,
              tsserver = {
                globalPlugins = {
                  {
                    name = '@mdx-js/typescript-plugin',
                    languages = { 'mdx' }
                  },
                },
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
        mdx_analyzer = {
          filetypes= { "mdx" },
        },
        Lua = {
          completion = {
            callSnippet = 'Replace'
          }
        }
      }

      -- Configure each LSP with completion capababilities, e.g. autocomplete,
      -- and all the buffer attach settings, e.g. hover and show go to definition.
      -- See :help lspconfig-setup
      local default_handler = function(server)
        local config = lspSettings[server] or {}

        config.capabilities = capabilities
        config.on_attach = on_attach

        lspconfig[server].setup(config)
      end

      -- See :help mason-lspconfig-dynamic-server-setup
      mason_lspconfig.setup_handlers({ default_handler })
    end


    local M = {}

    -- Setup Neovim LSP and Mason.
    function M.setup()
      setup_plugins()
      setup_behaviors()
      setup_servers()
    end

    M.setup()
  end
}
