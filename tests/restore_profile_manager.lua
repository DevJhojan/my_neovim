-- Prueba la restauración automática del perfil al entrar de nuevo al repositorio.
-- Recibe las expectativas del perfil desde profiles_alls_spec.lua.

local manager = require("project_profile.manager")

return function(profile)
  local repo_path = "/tmp/" .. profile.name .. "-restore-profile-spec"
  local original_cwd = vim.fn.getcwd()
  manager.clear_repo_profile(repo_path)
  vim.fn.mkdir(repo_path, "p")
  manager.set_profile(profile.name, repo_path)

  vim.cmd("cd " .. vim.fn.fnameescape(repo_path))
  vim.g.project_profile, vim.g.project_profile_config = nil, nil
  vim.g.project_profile_theme, vim.g.project_profile_completion = nil, nil
  manager.restore_current_repo()

  assert(vim.g.project_profile == profile.name, "expected profile to be restored")
  assert(vim.g.project_profile_completion == profile.completion, "unexpected restored completion")
  for color, proportion in pairs(profile.theme) do
    assert(vim.g.project_profile_theme[color] == proportion, "unexpected restored " .. color .. " theme proportion")
  end

  vim.cmd("cd " .. vim.fn.fnameescape(original_cwd))
  manager.clear_repo_profile(repo_path)
end
