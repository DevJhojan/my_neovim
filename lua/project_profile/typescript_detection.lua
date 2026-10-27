-- Módulo de detección de proyectos TypeScript.
--
-- Este módulo identifica automáticamente proyectos TypeScript al abrir archivos
-- dentro del repositorio y guarda el perfil asociado "typescript" para ese
-- proyecto. La detección se activa con el evento BufEnter y se persiste una sola
-- vez por proyecto para evitar avisos repetidos.
--
-- Un proyecto se considera TypeScript cuando existe cualquiera de estas señales:
-- - un archivo tsconfig.json en el árbol de carpetas del proyecto;
-- - o un package.json que declare la dependencia "typescript".
--
-- El perfil se guarda a través de project_profile.save_profile(), de modo que la
-- siguiente apertura del repositorio reutiliza la configuración ya elegida.
local M = {}
local detected_projects = {}
local project_profile = require("project_profile")

-- Determina si una ruta corresponde a un proyecto TypeScript.
--
-- Se acepta como proyecto TypeScript cuando existe un tsconfig.json en ese
-- directorio o cuando el package.json incluye la dependencia "typescript".
local function is_typescript_project(path)
  if vim.fn.filereadable(path .. "/tsconfig.json") == 1 then
    return true
  end

  local package_json = path .. "/package.json"
  if vim.fn.filereadable(package_json) ~= 1 then
    return false
  end

  local content = table.concat(vim.fn.readfile(package_json), "\n")
  return content:lower():match('"typescript"') ~= nil or content:lower():match("'typescript'") ~= nil
end

-- Busca hacia arriba desde el archivo abierto hasta encontrar la raíz del
-- proyecto TypeScript más cercano.
--
-- Esto permite detectar proyectos TypeScript aunque el archivo actual esté en un
-- subdirectorio, como src/ o app/.
local function find_typescript_root(path)
  local current_dir = vim.fn.fnamemodify(path, ":p:h")

  while true do
    if is_typescript_project(current_dir) then
      return current_dir
    end

    local parent_dir = vim.fn.fnamemodify(current_dir, ":h")
    if parent_dir == current_dir then
      return nil
    end
    current_dir = parent_dir
  end
end

-- Registra la detección automática al entrar a un buffer.
--
-- Cuando se abre un archivo dentro de un proyecto TypeScript, se guarda el
-- perfil "typescript" para ese proyecto si todavía no había sido detectado.
function M.setup()
  local group = vim.api.nvim_create_augroup("ProjectProfileTypeScriptDetection", { clear = true })

  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    callback = function(event)
      local project_root = find_typescript_root(vim.api.nvim_buf_get_name(event.buf))
      if project_root and not detected_projects[project_root] then
        detected_projects[project_root] = true
        project_profile.save_profile(project_root, "typescript")
        vim.notify("TypeScript project detected: " .. project_root)
      end
    end,
  })
end

return M
