local lspkind = require('lspkind')
local cmp = require('cmp')
local luasnip = require('luasnip')

local thick_sharp_borders = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" }
local double_sharp_borders = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" }
local thin_rounded_borders = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local vscode_icons = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

local M = {}

function M.setup()
  lspkind.init({
    symbol_map = vscode_icons
  })

  cmp.setup({
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

    completion = {
      completeopt = "menu,menuone",
    },

    formatting = {
      fields = { "kind", "abbr", "menu" },

      format = function(entry, vim_item)
        local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)

        local strings = vim.split(kind.kind, "%s", { trimempty = true })

        kind.kind = " " .. (strings[1] or "") .. " "
        kind.menu = "    (" .. (strings[2] or "") .. ")"

        return kind
      end
    },

    window = {
      documentation = {
        side_padding = 0,
        scrollbar = false,
        border = thin_rounded_borders,
        winhighlight = "Normal:Normal",
      },
      completion = {
        side_padding = 0,
        col_offset = -3,
        scrollbar = false,
        border = thin_rounded_borders,
        winhighlight = "Normal:Normal",
      }
    }
  })
end

return M
