-- Prueba: activa el LSP de TypeScript cuando el perfil activo es "typescript".
-- Aquí validamos la parte de activación del editor para que el servidor ts_ls
-- quede disponible sin depender de otra configuración externa.
local helpers = require("helpers")

return function()
  local project_profile = require("project_profile")
  local typescript_detection = require("project_profile.typescript_detection")
  local project_root = helpers.make_project("activate-ts-project")

  project_profile.save_profile(project_root, "typescript")

  local original_enable = vim.lsp.enable
  local enabled_servers = {}
  vim.lsp.enable = function(server)
    enabled_servers[#enabled_servers + 1] = server
  end

  typescript_detection.setup()
  vim.cmd("edit " .. vim.fn.fnameescape(project_root .. "/src/index.ts"))
  vim.lsp.enable = original_enable

  local joined = table.concat(enabled_servers, ",")
  assert(
    joined:match("ts_ls"),
    "ts_ls should be enabled when the active project profile is TypeScript"
  )

  print("PASS: 05_ts_activate_lsp")
end
