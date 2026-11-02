-- Prueba el guardado y la activación inmediata de un perfil para un repositorio.
-- Recibe las expectativas del perfil desde profiles_alls_spec.lua.

local manager = require("project_profile.manager")

return function(profile)
  local repo_path = "/tmp/" .. profile.name .. "-save-profile-spec"
  manager.clear_repo_profile(repo_path)
  manager.set_profile(profile.name, repo_path)

  assert(manager.get_profile(repo_path) == profile.name, "expected profile to be saved")
  assert(vim.g.project_profile == profile.name, "expected profile to become active")
  local config = manager.get_profile_config(profile.name)
  assert(config ~= nil, "expected profile config to exist")
  assert(config.completion == profile.completion, "unexpected completion provider")

  for color, proportion in pairs(profile.theme) do
    assert(config.theme[color] == proportion, "unexpected " .. color .. " theme proportion")
  end

  manager.clear_repo_profile(repo_path)
end
