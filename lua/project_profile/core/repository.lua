-- Lógica de negocio para guardar y restaurar el perfil del repositorio.
-- Este archivo se encarga solo de la relación entre la ruta del proyecto y su
-- perfil activo, dejando la persistencia en storage.lua y los comandos en
-- commands.lua.

local storage = require("project_profile.core.storage")
local themes = require("project_profile.core.themes")

local M = {}

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

M.PROFILES = themes
M.available_profiles = M.DEFAULT_PROFILES

function M.get_profile_config(profile_name)
  local profile = M.PROFILES[profile_name or "default"]
  return profile or M.PROFILES.default
end

local function apply_default_theme(theme)
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", fg = theme.foreground })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", fg = theme.foreground })
  vim.api.nvim_set_hl(0, "Keyword", { fg = theme.accent })
  vim.api.nvim_set_hl(0, "Comment", { fg = theme.secondary })
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE", fg = theme.foreground })
end

local function apply_godot_theme(theme)
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", fg = theme.foreground })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", fg = theme.foreground })
  vim.api.nvim_set_hl(0, "Keyword", { fg = theme.keyword })
end

local function apply_transparent_background()
  for _, group in ipairs({ "Normal", "NormalFloat" }) do
    local highlights = vim.api.nvim_get_hl(0, { name = group })
    highlights.bg = "NONE"
    vim.api.nvim_set_hl(0, group, highlights)
  end
end

local function restore_base_colorscheme()
  local scheme = vim.g.project_profile_base_colorscheme or vim.g.colors_name or "catppuccin-mocha"
  if scheme and scheme ~= "" then
    vim.cmd.colorscheme(scheme)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    apply_transparent_background()
    if vim.g.project_profile == "godot" then
      apply_godot_theme(M.PROFILES.godot.theme)
    elseif vim.g.project_profile == "default" then
      apply_default_theme(M.PROFILES.default.theme)
    end
  end,
})

function M.apply_profile_config(profile_name)
  local previous_profile = vim.g.project_profile
  local profile = M.get_profile_config(profile_name)

  if profile.name == "default" and previous_profile ~= "godot" and (previous_profile ~= "default" or not vim.g.project_profile_base_colorscheme) then
    vim.g.project_profile_base_colorscheme = vim.g.colors_name or "catppuccin-mocha"
  end

  vim.g.project_profile = profile_name or profile.name
  vim.g.project_profile_config = profile
  vim.g.project_profile_theme = profile.theme
  vim.g.project_profile_completion = profile.completion

  if (previous_profile == "default" and profile.name ~= "default") or (previous_profile == "godot" and profile.name == "default") then
    restore_base_colorscheme()
  end

  if profile.name == "default" then
    apply_default_theme(profile.theme)
  elseif profile.name == "godot" then
    apply_godot_theme(profile.theme)
  elseif previous_profile == "godot" then
    restore_base_colorscheme()
  end

  apply_transparent_background()
  return profile
end

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
  M.apply_profile_config(profile_name)
  return profile_name
end

-- Elimina el perfil guardado para un repositorio.
-- @param repo_path string|nil Ruta del repositorio. Si es nil, usa el actual.
function M.clear_repo_profile(repo_path)
  local repo_key = get_repo_key(repo_path)
  local state = storage.read_state()
  state[repo_key] = nil
  storage.write_state(state)

  if repo_key == vim.fn.getcwd() then
    M.apply_profile_config("default")
  end
end

-- Restaura el perfil asociado al repositorio abierto en la sesión actual.
-- Si no existe una configuración guardada, usa el perfil por defecto.
-- @return string Perfil activo final.
function M.restore_current_repo()
  local profile_name = M.get_profile(vim.fn.getcwd())
  if profile_name then
    M.apply_profile_config(profile_name)
    return profile_name
  end

  M.apply_profile_config("default")
  return "default"
end

return M
