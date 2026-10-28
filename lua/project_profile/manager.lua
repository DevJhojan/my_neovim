-- Módulo invocador: expone la API pública del perfil del proyecto.
-- La lógica real se guarda en submódulos dentro de project_profile/core.

local repository = require("project_profile.core.repository")
local commands = require("project_profile.core.commands")

local M = {}

-- Perfiles que el selector ofrece de forma predeterminada.
M.available_profiles = repository.DEFAULT_PROFILES

-- Obtiene el perfil guardado para una ruta o para el repositorio actual.
-- @param repo_path string|nil Ruta del repositorio; si se omite, usa la ruta actual.
-- @return string|nil Perfil guardado, o nil si no hay uno.
function M.get_profile(repo_path)
  return repository.get_profile(repo_path)
end

-- Guarda un perfil para una ruta y lo activa en la sesión actual.
-- @param profile_name string Nombre del perfil.
-- @param repo_path string|nil Ruta del repositorio; si se omite, usa la ruta actual.
-- @return string Nombre del perfil guardado.
function M.set_profile(profile_name, repo_path)
  return repository.set_profile(profile_name, repo_path)
end

-- Elimina el perfil guardado para una ruta o para el repositorio actual.
-- @param repo_path string|nil Ruta del repositorio; si se omite, usa la ruta actual.
function M.clear_repo_profile(repo_path)
  return repository.clear_repo_profile(repo_path)
end

-- Restaura el perfil guardado para el repositorio actual.
-- Si no hay ninguno, activa el perfil predeterminado.
-- @return string Nombre del perfil que queda activo.
function M.restore_current_repo()
  return repository.restore_current_repo()
end

-- Abre el selector y guarda la elección del usuario para el repositorio actual.
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

-- Configura los perfiles disponibles, registra los comandos y restaura el perfil.
-- @param opts table|nil Opciones de configuración; admite `profiles` para definir la lista.
function M.setup(opts)
  opts = opts or {}
  M.available_profiles = opts.profiles or repository.DEFAULT_PROFILES
  repository.available_profiles = M.available_profiles

  commands.setup(M)
  M.restore_current_repo()
end

return M
