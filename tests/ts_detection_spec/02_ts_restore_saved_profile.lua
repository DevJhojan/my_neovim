-- Prueba: recupera el perfil guardado para un proyecto TypeScript.
-- El objetivo es asegurar que la asociación ya persistida se reusa sin que el
-- usuario vuelva a elegir un perfil cada vez que abre el repositorio.
local helpers = require("helpers")

return function()
  local project_profile = require("project_profile")
  local project_root = helpers.make_project("restore-ts-project")

  project_profile.save_profile(project_root, "typescript")

  assert(
    project_profile.get_profile(project_root) == "typescript",
    "the TypeScript profile should be restored from the repo metadata"
  )

  print("PASS: 02_ts_restore_saved_profile")
end
