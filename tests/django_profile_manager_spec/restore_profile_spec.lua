-- Archivo: tests/django_profile_manager_spec/restore_profile_spec.lua
-- Verifica que el perfil Django guardado vuelva a activarse al reabrir un
-- repositorio sin pedir una nueva elección al usuario.

local manager = require("project_profile.manager")

-- Ruta aislada para simular un repositorio con perfil Django persistido.
local repo_path = "/tmp/django-profile-restore-spec"
local original_cwd = vim.fn.getcwd()

-- Guarda el perfil Django para el repositorio y luego simula una nueva sesión.
manager.clear_repo_profile(repo_path)
vim.fn.mkdir(repo_path, "p")
manager.set_profile("django", repo_path)

vim.cmd("cd " .. vim.fn.fnameescape(repo_path))
vim.g.project_profile = nil
vim.g.project_profile_config = nil
vim.g.project_profile_theme = nil
vim.g.project_profile_completion = nil

-- La restauración debe devolver el perfil junto con su autocompletado y tema.
manager.restore_current_repo()
assert(vim.g.project_profile == "django", "expected django profile to be restored")
assert(vim.g.project_profile_completion == "django", "expected django completion to be restored")
assert(vim.g.project_profile_theme.orange == 60, "expected django theme to be restored")

vim.cmd("cd " .. vim.fn.fnameescape(original_cwd))
manager.clear_repo_profile(repo_path)
print("django restore profile: ok")
