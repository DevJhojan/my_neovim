-- Prueba: guarda el perfil TypeScript cuando detecta un proyecto válido.
-- Esta comprobación valida que el perfil se persiste por repositorio para que la
-- siguiente apertura no vuelva a preguntar por la configuración del proyecto.
local helpers = require("helpers")

return function()
  local project_profile = require("project_profile")
  local project_root = helpers.make_project("persist-ts-project")

  local saved_profile = project_profile.save_profile(project_root, "typescript")

  assert(saved_profile == "typescript", "the selected TypeScript profile should be returned")
  assert(
    project_profile.get_profile(project_root) == "typescript",
    "the saved profile should be restored for the repo"
  )

  print("PASS: 01_ts_persist_profile")
end
