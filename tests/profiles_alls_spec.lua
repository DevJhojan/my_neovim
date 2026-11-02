-- Punto de entrada de las pruebas de todos los perfiles.
-- Mantiene las expectativas independientes de producción y delega guardar y
-- restaurar en archivos con una única responsabilidad cada uno.

local manager = require("project_profile.manager")
local verify_save = dofile("tests/save_profile_spec.lua")
local verify_restore = dofile("tests/restore_profile_manager.lua")

local profiles = {
  { name = "python", completion = "pyright", theme = { yellow = 60, blue = 30, white = 10 } },
  { name = "django", completion = "django", theme = { orange = 60, green = 30, white = 10 } },
  { name = "typescript", completion = "ts_ls", theme = { blue = 60, cyan = 30, white = 10 } },
  { name = "react", completion = "ts_ls", theme = { blue = 60, lime = 30, white = 10 } },
}

for _, profile in ipairs(profiles) do
  verify_save(profile)
  verify_restore(profile)
end

-- Comprueba que elegir otro perfil sustituya la selección anterior.
local replacements = {
  { previous = "django", selected = "typescript", completion = "ts_ls", theme = { cyan = 30 } },
  { previous = "typescript", selected = "django", completion = "django", theme = { orange = 60 } },
  { previous = "react", selected = "typescript", completion = "ts_ls", theme = { cyan = 30 } },
}
for index, case in ipairs(replacements) do
  local repo_path = "/tmp/profile-replacement-spec-" .. index
  manager.clear_repo_profile(repo_path)
  manager.set_profile(case.previous, repo_path)
  manager.set_profile(case.selected, repo_path)
  assert(manager.get_profile(repo_path) == case.selected, "expected new profile to replace previous")
  assert(vim.g.project_profile == case.selected, "expected replacement profile to become active")
  assert(vim.g.project_profile_completion == case.completion, "expected replacement completion to become active")
  for color, proportion in pairs(case.theme) do
    assert(vim.g.project_profile_theme[color] == proportion, "expected replacement theme to become active")
  end
  manager.clear_repo_profile(repo_path)
end

print("profiles_alls_spec: ok")
