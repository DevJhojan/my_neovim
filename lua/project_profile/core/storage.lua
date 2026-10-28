-- Almacena la relación entre repositorio y perfil seleccionado.
-- La información se guarda en un JSON dentro del directorio de datos de Neovim.

local M = {}

local function get_storage_path()
  local data_dir = vim.fn.stdpath("data")
  vim.fn.mkdir(data_dir, "p")
  return data_dir .. "/project_profiles.json"
end

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

function M.write_state(state)
  local path = get_storage_path()
  local file = assert(io.open(path, "w"))
  file:write(vim.json.encode(state))
  file:close()
end

return M
