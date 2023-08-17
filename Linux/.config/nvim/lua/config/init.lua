local M = {}

function M.setup()
  require('config.personal.opts').setup()
  require('config.personal.ui').setup()
end

return M
