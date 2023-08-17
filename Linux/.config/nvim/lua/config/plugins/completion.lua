local M = {}

function M.setup()
  local luasnip = require('luasnip')
  local cmp = require('cmp')

  cmp.setup {
    -- Use luasnip as the completion source.
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    -- Map keys to snippet/auto-complete commands.

    mapping = cmp.mapping.preset.insert({
        -- Accept currently selected item. 
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- <Tab> will cycle forwards through completion options.
        ["<Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          { "i", "s" }
          ),

        -- <Shift> + <Tab> will cycle backwards through completion options.
        ["<S-Tab>"] = cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
          { "i", "s" }
          ),
      }),

    -- nvim_lsp is the source of completion options
    -- luasnip is the source of doing the completion
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    },
  }
end

return M
