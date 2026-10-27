-- Prueba: actualiza la asociación del proyecto cuando el usuario cambia el perfil.
-- Este caso cubre el escenario de reelección para confirmar que la última
-- decisión queda registrada en lugar de la anterior.
local helpers = require("helpers")

return function()
  local project_profile = require("project_profile")
  local project_root = helpers.make_project("update-ts-project")

  project_profile.save_profile(project_root, "typescript")
  local updated_profile = project_profile.save_profile(project_root, "custom-typescript")

  assert(updated_profile == "custom-typescript", "the updated profile should be returned")
  assert(
    project_profile.get_profile(project_root) == "custom-typescript",
    "the latest profile should replace the previous one"
  )

  print("PASS: 03_ts_update_profile")
end
