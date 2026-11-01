-- Almacena la relación entre repositorio y perfil seleccionado.
-- La información se guarda en un JSON dentro del directorio de datos de Neovim.
-- Este módulo se ocupa únicamente de leer y escribir ese archivo.

local M = {}

-- Construye la ruta del archivo de perfiles y crea el directorio de datos si hace falta.
-- @return string Ruta completa del archivo JSON.
local function get_storage_path()
  local data_dir = vim.fn.stdpath("data")
  vim.fn.mkdir(data_dir, "p")
  return data_dir .. "/project_profiles.json"
end

-- Lee y decodifica el estado persistido de los perfiles.
-- Si el archivo no existe o está vacío, devuelve una tabla vacía.
-- @return table Mapa de rutas de repositorio a perfiles guardados.
function M.read_state()
  local path = get_storage_path()
  local file = io.open(path, "r")

  if not file then
    return {}
  end

  local content = file:read("*all")
  file:close()

  if content == "" then
    return {}
  end

  local ok, decoded = pcall(vim.json.decode, content)
  if ok and type(decoded) == "table" then
    return decoded
  end

  return {}
end

-- Codifica y guarda el estado completo de los perfiles en el archivo JSON.
-- @param state table Mapa de rutas de repositorio a perfiles.
function M.write_state(state)
  local path = get_storage_path()
  local file = assert(io.open(path, "w"))
  file:write(vim.json.encode(state))
  file:close()
end

return M
