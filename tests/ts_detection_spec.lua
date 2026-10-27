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
