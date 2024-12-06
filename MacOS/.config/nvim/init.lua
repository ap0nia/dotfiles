local stdout = vim.loop.new_tty(1, false)
local stdout = vim.loop.new_tty(1, false)

local echoraw = function(str)
    vim.fn.chansend(vim.v.stderr, str)
end

local function init()
  require('config').setup()
  require('lazy').setup('plugins')

  vim.api.nvim_create_user_command("SixView", function(opts)
    local path = '/Users/aponia/dotfiles/Linux/.config/fastfetch/logos/elysia-1.sixel'

    -- Read raw Sixel data
    local file = io.open(path, "rb")

    if not file then
        vim.api.nvim_err_writeln("Failed to open file: " .. path)
        return
    end

    local data = file:read("*a") -- Read entire file as binary

    file:close()

    -- Save cursor position
    echoraw("\27[s")

    local win_position = vim.api.nvim_win_get_position(0)

    local y = win_position[1]
    local x = win_position[2]

    -- Move cursor to the desired position
    echoraw(string.format("\27[%d;%dH", y, x + 1))

    -- Write the Sixel data
    echoraw(data)

    -- Restore cursor position
    echoraw("\27[u")
  end, {})
end

init()
