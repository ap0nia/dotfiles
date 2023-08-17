local M = {}

function M.setup()
  require('config.user.opts').setup()
  require('config.user.ui').setup()
end

return M
