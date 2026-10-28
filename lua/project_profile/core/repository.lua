-- Lógica de negocio para guardar y restaurar el perfil del repositorio.
-- Este archivo se encarga solo de la relación entre la ruta del proyecto y su
-- perfil activo, dejando la persistencia en storage.lua y los comandos en
-- commands.lua.

local storage = require("project_profile.core.storage")

local M = {}

-- Definición de perfiles admitidos por el sistema.
M.DEFAULT_PROFILES = {
  "default",
  "python",
  "django",
  "typescript",
  "react",
  "react-native",
  "bash",
  "rust",
  "godot",
}

-- Lista configurable de perfiles disponibles.
M.available_profiles = M.DEFAULT_PROFILES

-- Normaliza la clave del repositorio usando la ruta actual si no se pasa una.
local function get_repo_key(repo_path)
  return repo_path or vim.fn.getcwd()
end

-- Obtiene el perfil asociado a un repositorio.
-- @param repo_path string|nil Ruta del repositorio. Si es nil, usa el actual.
-- @return string|nil Perfil guardado para ese repositorio.
function M.get_profile(repo_path)
  local repo_key = get_repo_key(repo_path)
  local state = storage.read_state()
  return state[repo_key]
end

-- Guarda un perfil para un repositorio y lo deja activo en la sesión actual.
-- @param profile_name string Nombre del perfil a guardar.
-- @param repo_path string|nil Ruta del repositorio. Si es nil, usa el actual.
-- @return string El perfil guardado.
function M.set_profile(profile_name, repo_path)
  local repo_key = get_repo_key(repo_path)
  local state = storage.read_state()
  state[repo_key] = profile_name
  storage.write_state(state)
  vim.g.project_profile = profile_name
  return profile_name
end

-- Elimina el perfil guardado para un repositorio.
-- @param repo_path string|nil Ruta del repositorio. Si es nil, usa el actual.
function M.clear_repo_profile(repo_path)
  local repo_key = get_repo_key(repo_path)
  local state = storage.read_state()
  state[repo_key] = nil
  storage.write_state(state)

  if vim.g.project_profile == M.get_profile(repo_key) then
    vim.g.project_profile = nil
  end
end

-- Restaura el perfil asociado al repositorio abierto en la sesión actual.
-- Si no existe una configuración guardada, usa el perfil por defecto.
-- @return string Perfil activo final.
function M.restore_current_repo()
  local profile_name = M.get_profile(vim.fn.getcwd())
  if profile_name then
    vim.g.project_profile = profile_name
    return profile_name
  end

  vim.g.project_profile = "default"
  return "default"
end

return M
