-- Verifica que el perfil TypeScript se guarde para un repositorio, quede
-- activo y exponga su autocompletado y tema propios.

local manager = require("project_profile.manager")
local repo_path = "/tmp/typescript-profile-save-spec"

manager.clear_repo_profile(repo_path)
manager.set_profile("typescript", repo_path)

assert(manager.get_profile(repo_path) == "typescript", "expected typescript profile to be saved")
assert(vim.g.project_profile == "typescript", "expected typescript profile to become active")

local profile = manager.get_profile_config("typescript")
assert(profile ~= nil, "expected typescript profile config to exist")
assert(profile.completion == "ts_ls", "expected ts_ls as typescript completion provider")
assert(profile.theme.blue == 60, "expected typescript theme blue proportion to be 60")
assert(profile.theme.cyan == 30, "expected typescript theme cyan proportion to be 30")
assert(profile.theme.white == 10, "expected typescript theme white proportion to be 10")

manager.clear_repo_profile(repo_path)
print("typescript save profile: ok")
