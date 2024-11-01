path_to_python_from_venv = "/venv/bin/python"


local pythonPath = function()
  -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
  -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
  -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
  local cwd = vim.fn.getcwd()
  if vim.fn.executable(cwd .. path_to_python_from_venv) == 1 then
    return cwd .. path_to_python_from_venv
  else
    return '/usr/bin/python'
  end
end

-- For sing file
LaunchFileConf = {
  -- The first three options are required by nvim-dap
  type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
  request = 'launch',
  name = "Launch current buffer file",
  -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
  pythonPath = pythonPath,
  program = "${file}", -- This configuration will launch the current file if used.
}

LaunchAppConf = {
  -- The first three options are required by nvim-dap
  type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
  request = 'launch',
  name = "Launch main.py",
  -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

  program = "main.py", -- This configuration will launch the current file if used.
  pythonPath = pythonPath,
}


-- For django
DjangoConf = {
  type = 'python',
  request = 'launch',
  name = 'Launch Django',
  program = 'manage.py',
  args = { 'runserver', '--noreload' },

  -- env = {
  --   DEBUG_SQL = '1',
  -- },
  pythonPath = pythonPath,
}

LaunchTestConf = {
  type = 'python',
  request = 'launch',
  name = 'Launch current buffer test',
  module = 'pytest',
  -- program = "${workspaceFolder}/venv/bin/python",
  -- cwd = "${workspaceFolder}",
  -- args = { '-m', 'pytest', '-vv', '-s', 'rpc/client/client_backend/tests/bl/calculator/test_supply_plan.py' },
  -- args = { '-m', 'pytest', },
  args = {
    "${file}",
    "-sv",
    "--log-cli-level=INFO",
    "--log-file=test_out.log",
  },
  pythonPath = pythonPath,
  -- console= "integratedTerminal",
  -- env = {
  --         PYTHONPATH = "${workspaceFolder}",
  -- },
  -- stopOnEntry = true,
}


gdscript = {
  type = "godot",
  request = "launch",
  name = "Launch scene",
  project = "${workspaceFolder}",
  launch_scene = true,
}


java = {
  type = "java",
  request = "launch",
  name = "java test",
  projectName = "Template Mod Generator",
  mainClass = "net.fabricmc.devlaunchinjector.Main",
  javaExec = "/usr/bin/java",
  vmArgs =
  "-Dfabric.dli.config=/Users/nikitakurkurin/MinecraftModsCreation/HPHud/.gradle/loom-cache/launch.cfg -Dfabric.dli.env=client -XstartOnFirstThread -Dfabric.dli.main=net.fabricmc.loader.impl.launch.knot.KnotClient",
  cwd = "${workspaceFolder}/run",
}


local dap = require('dap')


dap.set_log_level('DEBUG')


dap.configurations.python = {
  LaunchAppConf,
  LaunchFileConf,
  DjangoConf,
  LaunchTestConf,
}



dap.adapters.python = {
  type = 'executable',
  -- command = os.getenv("VIRTUAL_ENV") .. "/bin/python"; -- before start nvim must be in need environment
  command = vim.fn.getcwd() .. "/venv/bin/python", -- before start nvim must be in need environment
  args = { '-m', 'debugpy.adapter' },
}


dap.adapters.godot = {
  type = "server",
  host = '127.0.0.1',
  port = 59502,
}


local cpptools_path = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
dap.adapters.lldb = {
  id = 'lldb',
  type = 'executable',
  command = cpptools_path,
}

local HOME = os.getenv("HOME") or os.getenv("USERPROFILE")
local RUST_DEBUGGER_PORT = 13001


dap.adapters.codelldb = {
  type = 'server',
  port = RUST_DEBUGGER_PORT,
  executable = {
    command = HOME .. '/Documents/rust_debugger/extension/adapter/codelldb',
    args = { "--port", RUST_DEBUGGER_PORT },
  }
}


function getDirectoryName(path)
  local pattern = "([^/\\]+)[/\\]?$"
  local name = path:match(pattern)
  return name
end

start_file_name = getDirectoryName(vim.fn.getcwd())

rust = {
  name = "(lldb) Launch file",
  type = "codelldb",
  request = "launch",
  program = string.format('${workspaceFolder}/target/debug/%s', start_file_name),
  cwd = '${workspaceFolder}',
}

local dap, dapui = require("dap"), require("dapui")

dap.listeners.before.event_terminated["keep_open"] = function()
  dapui.open({})
end
dap.listeners.before.event_exited["keep_open"] = function()
  dapui.open({})
end


-- local old_func = dap.listeners.after.event_initialized["dapui_config"]

-- dap_repl = require('dap.repl')
--
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   old_func()
--   dap_repl.append(first_text_for_output_after_repl_is_start)
-- end
--
--
-- first_text_for_output_after_repl_is_start = ""


return {}
