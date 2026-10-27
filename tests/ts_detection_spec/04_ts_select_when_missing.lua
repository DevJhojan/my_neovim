-- Prueba: pide elegir un perfil cuando no existe una asociación guardada.
-- Esto simula la experiencia de usuario al abrir un proyecto TypeScript por
-- primera vez y confirmar que la selección queda persistida.
local helpers = require("helpers")

return function()
  local project_profile = require("project_profile")
  local typescript_detection = require("project_profile.typescript_detection")
  local project_root = helpers.make_project("select-ts-project")

  local original_ui_select = vim.ui.select
  vim.ui.select = function(items, opts, on_choice)
    assert(on_choice, "a callback should be provided when asking for the project profile")
    assert(items[1] == "typescript", "the selection should offer the TypeScript profile")
    on_choice(items[1])
  end

  typescript_detection.setup()
  vim.cmd("edit " .. vim.fn.fnameescape(project_root .. "/src/index.ts"))
  vim.ui.select = original_ui_select

  assert(
    project_profile.get_profile(project_root) == "typescript",
    "a missing TypeScript profile should be saved after the user selects it"
  )

  print("PASS: 04_ts_select_when_missing")
end
