-- Utilidades compartidas para la suite de detección de proyectos TypeScript.
-- Se centralizan las creaciones de proyectos de prueba y los stubs de UI/LSP para
-- mantener cada caso enfocado en una sola comprobación.
local M = {}

-- Crea un proyecto TypeScript temporal con package.json y un archivo fuente.
-- root_name define el nombre del paquete y source_name el nombre del archivo
-- dentro de src/; ambos usan valores predeterminados si se omiten.
-- Devuelve la ruta de la raíz del proyecto creado.
function M.make_project(root_name, source_name)
  local project_root = vim.fn.tempname()
  vim.fn.mkdir(project_root .. "/src", "p")

  local package_file = assert(io.open(project_root .. "/package.json", "w"))
  local package_json = string.format(
    '{\n  "name": "%s",\n  "dependencies": {\n    "typescript": "^5.5.0"\n  }\n}',
    root_name or "sample-ts-project"
  )
  package_file:write(package_json)
  package_file:close()

  local file_name = source_name or "index.ts"
  local source_file = assert(io.open(project_root .. "/src/" .. file_name, "w"))
  source_file:write("export const value = 'ok';\n")
  source_file:close()

  return project_root
end

-- Mantiene un alias explícito para crear proyectos cuyo nombre se proporciona.
-- Reutiliza make_project para generar los mismos archivos de prueba y devuelve
-- la ruta de la raíz creada.
function M.new_project_with_name(name, source_name)
  return M.make_project(name, source_name)
end

-- Sustituye temporalmente vim.ui.select por una selección determinista.
-- Ejecuta callback mientras el stub está instalado, elige el primer elemento
-- disponible y restaura la función original incluso si callback falla.
function M.with_stubbed_ui_select(callback)
  local original_ui_select = vim.ui.select
  vim.ui.select = function(items, opts, on_choice)
    assert(on_choice, "a callback should be provided when asking for the project profile")
    on_choice(items[1])
  end

  local ok, err = pcall(callback)
  vim.ui.select = original_ui_select

  if not ok then
    error(err)
  end
end

-- Sustituye temporalmente vim.lsp.enable y registra los servidores solicitados.
-- Ejecuta callback con la lista de servidores registrados, restaura la función
-- original incluso si callback falla y devuelve esa lista.
function M.with_stubbed_lsp_enable(callback)
  local original_enable = vim.lsp.enable
  local enabled_servers = {}

  vim.lsp.enable = function(server)
    enabled_servers[#enabled_servers + 1] = server
  end

  local ok, err = pcall(callback, enabled_servers)
  vim.lsp.enable = original_enable

  if not ok then
    error(err)
  end

  return enabled_servers
end

return M
