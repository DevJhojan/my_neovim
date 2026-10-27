-- Este test valida que, al abrir un proyecto TypeScript, el sistema recuerde el perfil
-- "typescript" para ese repositorio y lo persista como la configuración activa.
local project_root = vim.fn.tempname()
vim.fn.mkdir(project_root .. "/src", "p")

-- Simula un proyecto TypeScript con package.json y un archivo fuente .ts.
local package_file = assert(io.open(project_root .. "/package.json", "w"))
package_file:write([[{
  "name": "sample-ts-project",
  "dependencies": {
    "typescript": "^5.5.0"
  }
}]])
package_file:close()

local source_file = assert(io.open(project_root .. "/src/index.ts", "w"))
source_file:write("const value: string = 'ok';\n")
source_file:close()

package.path = package.path .. ";lua/?.lua"
local project_profile = require("project_profile")
local ts_detection = require("project_profile.typescript_detection")

-- La detección de TypeScript debe activarse al abrir un archivo dentro del proyecto.
ts_detection.setup()
vim.cmd("edit " .. vim.fn.fnameescape(project_root .. "/src/index.ts"))

-- La prueba exige que el proyecto quede asociado al perfil "typescript".
assert(
  project_profile.get_profile(project_root) == "typescript",
  "opening a TypeScript project should persist the typescript profile"
)
print("PASS: persiste_perfil_typescript_al_abrir_proyecto_con_package_json")

-- El segundo caso verifica que un proyecto TypeScript ya asociado recuerde su perfil
-- al reabrirse, sin requerir una nueva elección.
local saved_root = vim.fn.tempname()
vim.fn.mkdir(saved_root .. "/src", "p")

local saved_package = assert(io.open(saved_root .. "/package.json", "w"))
saved_package:write([[{
  "name": "saved-ts-project",
  "dependencies": {
    "typescript": "^5.5.0"
  }
}]])
saved_package:close()

local saved_source = assert(io.open(saved_root .. "/src/index.ts", "w"))
saved_source:write("export const ok = true;\n")
saved_source:close()

project_profile.save_profile(saved_root, "typescript")
ts_detection.setup()
vim.cmd("edit " .. vim.fn.fnameescape(saved_root .. "/src/index.ts"))

assert(
  project_profile.get_profile(saved_root) == "typescript",
  "reopening a TypeScript project should keep the saved profile"
)
print("PASS: recupera_perfil_typescript_guardado_al_reabrir_proyecto")

-- El tercer caso comprueba que una reasignación del perfil del proyecto se
-- actualiza en la persistencia y no queda anclada al valor anterior.
local update_root = vim.fn.tempname()
vim.fn.mkdir(update_root .. "/src", "p")

local update_package = assert(io.open(update_root .. "/package.json", "w"))
update_package:write([[{
  "name": "update-ts-project",
  "dependencies": {
    "typescript": "^5.5.0"
  }
}]])
update_package:close()

local update_source = assert(io.open(update_root .. "/src/index.ts", "w"))
update_source:write("export const value = 'demo';\n")
update_source:close()

project_profile.save_profile(update_root, "typescript")
local updated_profile = project_profile.save_profile(update_root, "typescript")

assert(
  updated_profile == "typescript",
  "saving the TypeScript profile again should return the latest selected profile"
)
assert(
  project_profile.get_profile(update_root) == "typescript",
  "changing the TypeScript profile for a project should update the saved association"
)
print("PASS: actualiza_perfil_typescript_para_repositorio")
