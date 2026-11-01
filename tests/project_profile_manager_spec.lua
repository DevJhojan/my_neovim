-- Prueba de la gestión de perfiles por repositorio.
-- Verifica que el perfil se guarde por primera vez y que una nueva elección
-- reemplace la anterior sin dejar un valor obsoleto.
--
-- Flujo cubierto:
-- 1. Limpia la ruta temporal del repositorio.
-- 2. Guarda un primer perfil (python).
-- 3. Actualiza el mismo repositorio con otro perfil (typescript).
-- 4. Confirma que el valor final devuelto corresponde al perfil más reciente.

local manager = require("project_profile.manager")

local repo_path = "/tmp/project-profile-manager-spec"
local first_profile = "python"
local second_profile = "typescript"

-- Asegura un estado limpio antes de iniciar la prueba.
manager.clear_repo_profile(repo_path)

-- Guarda la primera selección del perfil para este repositorio.
manager.set_profile(first_profile, repo_path)
assert(manager.get_profile(repo_path) == first_profile, "expected first profile to be saved")

-- Verifica que una nueva selección reemplace la anterior.
manager.set_profile(second_profile, repo_path)
assert(manager.get_profile(repo_path) == second_profile, "expected replaced profile to be saved")
assert(vim.g.project_profile == second_profile, "expected the newly selected profile to be active")

-- Verifica que el perfil de Django puede guardarse y activarse como selección del repositorio.
manager.clear_repo_profile(repo_path)
manager.set_profile("django", repo_path)
assert(manager.get_profile(repo_path) == "django", "expected django profile to be saved")
assert(vim.g.project_profile == "django", "expected django profile to become active")
local django_profile = manager.get_profile_config("django")
assert(django_profile ~= nil, "expected django profile config to exist")
assert(django_profile.completion == "django", "expected django completion provider to be set")
assert(django_profile.theme.orange == 60, "expected django theme orange proportion to be 60")
assert(django_profile.theme.green == 30, "expected django theme green proportion to be 30")
assert(django_profile.theme.white == 10, "expected django theme white proportion to be 10")

-- Verifica la configuración específica del perfil de Python.
local python_profile = manager.get_profile_config("python")
assert(python_profile ~= nil, "expected python profile config to exist")
assert(python_profile.completion == "pyright", "expected pyright as python completion provider")
assert(python_profile.theme.yellow == 60, "expected python theme yellow proportion to be 60")
assert(python_profile.theme.blue == 30, "expected python theme blue proportion to be 30")
assert(python_profile.theme.white == 10, "expected python theme white proportion to be 10")

-- Simula una sesión nueva en el repositorio y verifica la restauración del perfil.
local original_cwd = vim.fn.getcwd()
vim.fn.mkdir(repo_path, "p")
manager.set_profile(first_profile, repo_path)
vim.cmd("cd " .. vim.fn.fnameescape(repo_path))
vim.g.project_profile = nil
vim.g.project_profile_config = nil
vim.g.project_profile_theme = nil
vim.g.project_profile_completion = nil

manager.restore_current_repo()
assert(vim.g.project_profile == first_profile, "expected python profile to be restored")
assert(vim.g.project_profile_completion == "pyright", "expected python completion to be restored")
assert(vim.g.project_profile_theme.yellow == 60, "expected python theme to be restored")

vim.cmd("cd " .. vim.fn.fnameescape(original_cwd))
manager.clear_repo_profile(repo_path)

print("project_profile_manager_spec: ok")
