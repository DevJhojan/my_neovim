-- Archivo: tests/python_profile_manager_spec/save_profile_spec.lua
-- Verifica que el perfil de Python pueda guardarse para un repositorio y que
-- se active inmediatamente en la sesión actual.

local manager = require("project_profile.manager")

-- Ruta de prueba aislada para no mezclar el estado con otros repositorios.
local repo_path = "/tmp/python-profile-save-spec"

-- Limpia el estado previo del repositorio y guarda el perfil Python.
manager.clear_repo_profile(repo_path)
manager.set_profile("python", repo_path)

-- La persistencia del perfil debe ser consistente con la nueva selección.
assert(manager.get_profile(repo_path) == "python", "expected python profile to be saved")
assert(vim.g.project_profile == "python", "expected python profile to become active")

-- La configuración del perfil debe aplicar autocompletado y tema esperados.
local profile = manager.get_profile_config("python")
assert(profile ~= nil, "expected python profile config to exist")
assert(profile.completion == "pyright", "expected pyright as python completion provider")
assert(profile.theme.yellow == 60, "expected python theme yellow proportion to be 60")
assert(profile.theme.blue == 30, "expected python theme blue proportion to be 30")
assert(profile.theme.white == 10, "expected python theme white proportion to be 10")

manager.clear_repo_profile(repo_path)
print("python save profile: ok")
