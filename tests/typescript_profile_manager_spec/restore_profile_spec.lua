-- Verifica que el perfil TypeScript guardado se restaure automáticamente al
-- volver a abrir el repositorio, junto con su completado y tema.

local manager = require("project_profile.manager")
local repo_path = "/tmp/typescript-profile-restore-spec"
local original_cwd = vim.fn.getcwd()

manager.clear_repo_profile(repo_path)
vim.fn.mkdir(repo_path, "p")
manager.set_profile("typescript", repo_path)

vim.cmd("cd " .. vim.fn.fnameescape(repo_path))
vim.g.project_profile = nil
vim.g.project_profile_config = nil
vim.g.project_profile_theme = nil
vim.g.project_profile_completion = nil

manager.restore_current_repo()
assert(vim.g.project_profile == "typescript", "expected typescript profile to be restored")
assert(vim.g.project_profile_completion == "ts_ls", "expected typescript completion to be restored")
assert(vim.g.project_profile_theme.blue == 60, "expected typescript theme to be restored")

vim.cmd("cd " .. vim.fn.fnameescape(original_cwd))
manager.clear_repo_profile(repo_path)
print("typescript restore profile: ok")
