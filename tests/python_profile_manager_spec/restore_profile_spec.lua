-- Archivo: tests/python_profile_manager_spec/restore_profile_spec.lua
-- Verifica que, al abrir un repositorio guardado, el perfil de Python se
-- restaure automáticamente sin requerir una nueva selección.

local manager = require("project_profile.manager")

-- Ruta aislada para simular un repositorio con perfil previamente guardado.
local repo_path = "/tmp/python-profile-restore-spec"
local original_cwd = vim.fn.getcwd()

-- Se limpia el estado previo y se guarda un perfil Python para el repositorio.
manager.clear_repo_profile(repo_path)
vim.fn.mkdir(repo_path, "p")
manager.set_profile("python", repo_path)

-- Simula una nueva sesión dentro del repositorio con todas las variables del
-- perfil borradas para comprobar la restauración automática.
vim.cmd("cd " .. vim.fn.fnameescape(repo_path))
vim.g.project_profile = nil
vim.g.project_profile_config = nil
vim.g.project_profile_theme = nil
vim.g.project_profile_completion = nil

-- La restauración debe reactivar el perfil y sus valores visibles.
manager.restore_current_repo()
assert(vim.g.project_profile == "python", "expected python profile to be restored")
assert(vim.g.project_profile_completion == "pyright", "expected python completion to be restored")
assert(vim.g.project_profile_theme.yellow == 60, "expected python theme to be restored")

vim.cmd("cd " .. vim.fn.fnameescape(original_cwd))
manager.clear_repo_profile(repo_path)
print("python restore profile: ok")
