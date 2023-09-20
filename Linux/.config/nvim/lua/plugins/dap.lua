return {
  "mfussenegger/nvim-dap",

  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        local dapui = require('dapui')

        dapui.setup()

        vim.keymap.set('n', '<space>dc', dapui.close, { silent = true, script = true })
        vim.keymap.set('n', '<space>do', dapui.open, { silent = true, script = true })
        vim.keymap.set('n', '<space>dt', dapui.toggle, { silent = true, script = true })
      end,
    },
    {
      'mxsdev/nvim-dap-vscode-js',
      config = function()
        require('dap-vscode-js').setup({
          node_path = "node",
          debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
          adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost", "node", "chrome" },
        })
      end
    }
  },
  config = function()
    local dap = require("dap")

    if not dap.adapters["pwa-node"] then
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {
            -- require("mason-registry").get_package("js-debug-adapter"):get_install_path() .. "/js-debug/src/dapDebugServer.js", "${port}",
            require("mason-registry").get_package("js-debug-adapter"):get_install_path() .. "/out/src/vsDebugServer.js", "${port}",
          },
        },
      }
    end

    for _, language in ipairs({ "typescript", "javascript" }) do
      dap.configurations[language] = {
        {
          	type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
			outFiles = { "${workspaceFolder}/dist/**/*.js" },
			runtimeExecutable = "${workspaceFolder}/node_modules/.bin/tsx",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end
  end,
}
