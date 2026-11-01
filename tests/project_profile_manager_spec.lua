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
local python_profile_name = "python"
local django_profile_name = "django"

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
manager.set_profile(django_profile_name, repo_path)
assert(manager.get_profile(repo_path) == django_profile_name, "expected django profile to be saved")
assert(vim.g.project_profile == django_profile_name, "expected django profile to become active")
local django_profile_config = manager.get_profile_config(django_profile_name)
assert(django_profile_config ~= nil, "expected django profile config to exist")
assert(django_profile_config.completion == "django", "expected django completion provider to be set")
assert(django_profile_config.theme.orange == 60, "expected django theme orange proportion to be 60")
assert(django_profile_config.theme.green == 30, "expected django theme green proportion to be 30")
assert(django_profile_config.theme.white == 10, "expected django theme white proportion to be 10")

-- Verifica la restauración automática del perfil de Django al reabrir el repositorio.
local original_cwd_restore = vim.fn.getcwd()
vim.fn.mkdir(repo_path, "p")
manager.set_profile(django_profile_name, repo_path)
vim.cmd("cd " .. vim.fn.fnameescape(repo_path))
vim.g.project_profile = nil
vim.g.project_profile_config = nil
vim.g.project_profile_theme = nil
vim.g.project_profile_completion = nil
manager.restore_current_repo()
assert(vim.g.project_profile == django_profile_name, "expected django profile to be restored on repo reopen")
assert(vim.g.project_profile_completion == "django", "expected django completion to be restored")
assert(vim.g.project_profile_theme.orange == 60, "expected django theme to be restored")
vim.cmd("cd " .. vim.fn.fnameescape(original_cwd_restore))
manager.clear_repo_profile(repo_path)

-- Verifica que cambiar de perfil reemplaza la configuración previa de Django.
local swap_repo = "/tmp/project-django-replace-spec"
manager.clear_repo_profile(swap_repo)
manager.set_profile("django", swap_repo)
manager.set_profile("typescript", swap_repo)
assert(manager.get_profile(swap_repo) == "typescript", "expected new profile to replace previous django profile")
assert(vim.g.project_profile == "typescript", "expected typescript profile to stay active after replacement")
manager.clear_repo_profile(swap_repo)

-- Verifica la configuración específica del perfil de Python.
local python_profile_config = manager.get_profile_config(python_profile_name)
assert(python_profile_config ~= nil, "expected python profile config to exist")
assert(python_profile_config.completion == "pyright", "expected pyright as python completion provider")
assert(python_profile_config.theme.yellow == 60, "expected python theme yellow proportion to be 60")
assert(python_profile_config.theme.blue == 30, "expected python theme blue proportion to be 30")
assert(python_profile_config.theme.white == 10, "expected python theme white proportion to be 10")

-- Simula una sesión nueva en el repositorio y verifica la restauración del perfil.
local original_cwd = vim.fn.getcwd()
vim.fn.mkdir(repo_path, "p")
manager.set_profile(python_profile_name, repo_path)
vim.cmd("cd " .. vim.fn.fnameescape(repo_path))
vim.g.project_profile = nil
vim.g.project_profile_config = nil
vim.g.project_profile_theme = nil
vim.g.project_profile_completion = nil

manager.restore_current_repo()
assert(vim.g.project_profile == python_profile_name, "expected python profile to be restored")
assert(vim.g.project_profile_completion == "pyright", "expected python completion to be restored")
assert(vim.g.project_profile_theme.yellow == 60, "expected python theme to be restored")

vim.cmd("cd " .. vim.fn.fnameescape(original_cwd))
manager.clear_repo_profile(repo_path)

print("project_profile_manager_spec: ok")
