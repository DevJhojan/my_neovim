-- Prueba: conserva los servidores ya activos al habilitar TypeScript.
-- La intención es evitar que la activación de ts_ls deshabilite otras
-- configuraciones de LSP que ya estaban funcionando para este proyecto.
local helpers = require("helpers")

return function()
  local project_profile = require("project_profile")
  local typescript_detection = require("project_profile.typescript_detection")
  local project_root = helpers.make_project("preserve-ts-project")

  project_profile.save_profile(project_root, "typescript")

  local existing_servers = { "lua_ls", "rust_analyzer" }
  local original_enable = vim.lsp.enable
  vim.lsp.enable = function(server)
    existing_servers[#existing_servers + 1] = server
  end

  typescript_detection.setup()
  vim.cmd("edit " .. vim.fn.fnameescape(project_root .. "/src/index.ts"))
  vim.lsp.enable = original_enable

  assert(existing_servers[1] == "lua_ls", "existing servers should remain available")
  assert(existing_servers[2] == "rust_analyzer", "previous servers should not be replaced")
  assert(existing_servers[#existing_servers] == "ts_ls", "ts_ls should be added without dropping the others")

  print("PASS: 06_ts_preserve_other_servers")
end
