local function init()
  require('config').setup()
  require('lazy').setup('plugins')
end

init()
