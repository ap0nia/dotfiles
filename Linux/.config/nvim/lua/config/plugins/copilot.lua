local M = {}

function M.setup()
  require('copilot').setup({
    cmd = "Copilot",
    event = "InsertEnter",
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<C-J>",
      },
    },
    filetypes = {
      javascript = true,
      typescript = true,
    }
  })

  vim.keymap.set("n", "<space>c", require('copilot.panel').open, { silent = true, script = true })
end

return M
