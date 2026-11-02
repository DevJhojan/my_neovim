-- Archivo: tests/project_profile_manager_spec/replacement_spec.lua
-- Verifica que, al cambiar la elección de perfil del repositorio, la nueva
-- configuración reemplaza a la anterior sin dejar un perfil obsoleto activo.

local manager = require("project_profile.manager")

-- Ruta aislada para probar la sustitución del perfil de un repositorio.
local repo_path = "/tmp/profile-replacement-spec"

-- Guarda un perfil inicial y luego otro más reciente para comprobar el reemplazo.
manager.clear_repo_profile(repo_path)
manager.set_profile("django", repo_path)
manager.set_profile("typescript", repo_path)

-- La elección nueva debe sobrescribir la anterior y quedar como perfil activo.
assert(manager.get_profile(repo_path) == "typescript", "expected new profile to replace previous profile")
assert(vim.g.project_profile == "typescript", "expected typescript profile to stay active after replacement")

manager.clear_repo_profile(repo_path)
print("profile replacement: ok")

-- Verifica que una nueva elección sustituya el perfil TypeScript guardado
-- y aplique la configuración del perfil seleccionado.
local typescript_repo_path = "/tmp/typescript-profile-replacement-spec"
manager.clear_repo_profile(typescript_repo_path)
manager.set_profile("typescript", typescript_repo_path)
manager.set_profile("django", typescript_repo_path)

assert(manager.get_profile(typescript_repo_path) == "django", "expected django profile to replace typescript")
assert(vim.g.project_profile == "django", "expected django profile to become active after replacement")
assert(vim.g.project_profile_completion == "django", "expected replacement completion to be applied")
assert(vim.g.project_profile_theme.orange == 60, "expected replacement theme to be applied")

manager.clear_repo_profile(typescript_repo_path)
print("typescript profile replacement: ok")
