-- Archivo: tests/django_profile_manager_spec/save_profile_spec.lua
-- Verifica que el perfil de Django pueda guardarse para un repositorio y que
-- despliegue la configuración visual y de completado esperadas.

local manager = require("project_profile.manager")

-- Ruta aislada para validar la persistencia del perfil Django.
local repo_path = "/tmp/django-profile-save-spec"

-- Limpia el estado previo y guarda la elección del perfil Django.
manager.clear_repo_profile(repo_path)
manager.set_profile("django", repo_path)

-- El repositorio debe recordar el perfil y dejarlo activo en la sesión.
assert(manager.get_profile(repo_path) == "django", "expected django profile to be saved")
assert(vim.g.project_profile == "django", "expected django profile to become active")

-- La configuración del perfil debe definir autocompletado y tema del Django.
local profile = manager.get_profile_config("django")
assert(profile ~= nil, "expected django profile config to exist")
assert(profile.completion == "django", "expected django completion provider to be set")
assert(profile.theme.orange == 60, "expected django theme orange proportion to be 60")
assert(profile.theme.green == 30, "expected django theme green proportion to be 30")
assert(profile.theme.white == 10, "expected django theme white proportion to be 10")

manager.clear_repo_profile(repo_path)
print("django save profile: ok")
