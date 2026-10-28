-- Módulo invocador: expone la API pública del perfil del proyecto.
-- La lógica real se guarda en submódulos dentro de project_profile/core.

local repository = require("project_profile.core.repository")
local commands = require("project_profile.core.commands")

local M = {}

M.available_profiles = repository.DEFAULT_PROFILES

function M.get_profile(repo_path)
  return repository.get_profile(repo_path)
end

function M.set_profile(profile_name, repo_path)
  return repository.set_profile(profile_name, repo_path)
end

function M.clear_repo_profile(repo_path)
  return repository.clear_repo_profile(repo_path)
end

function M.restore_current_repo()
  return repository.restore_current_repo()
end

function M.prompt_for_profile()
  local choices = M.available_profiles or repository.DEFAULT_PROFILES

  vim.ui.select(choices, {
    prompt = "Select a project profile",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if not choice then
      return
    end

    M.set_profile(choice, vim.fn.getcwd())
    vim.notify("Project profile saved: " .. choice, vim.log.levels.INFO)
  end)
end

function M.setup(opts)
  opts = opts or {}
  M.available_profiles = opts.profiles or repository.DEFAULT_PROFILES
  repository.available_profiles = M.available_profiles

  commands.setup(M)
  M.restore_current_repo()
end

return M
