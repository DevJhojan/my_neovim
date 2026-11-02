-- Archivo: tests/project_profile_manager_spec.lua
-- Este archivo actúa como punto de entrada de la suite de pruebas del gestor
-- de perfiles. Su función es ejecutar cada prueba pequeña por separado para
-- mantener el comportamiento del sistema fácil de seguir y de depurar.

local specs = {
  "tests/python_profile_manager_spec/save_profile_spec.lua",
  "tests/python_profile_manager_spec/restore_profile_spec.lua",
  "tests/django_profile_manager_spec/save_profile_spec.lua",
  "tests/django_profile_manager_spec/restore_profile_spec.lua",
  "tests/typescript_profile_manager_spec/save_profile_spec.lua",
  "tests/typescript_profile_manager_spec/restore_profile_spec.lua",
  "tests/project_profile_manager_spec/replacement_spec.lua",
}

-- Recorre la lista de archivos de prueba y los ejecuta en orden.
-- Cada archivo cubre un caso concreto: guardar, restaurar o reemplazar perfil.
for _, spec in ipairs(specs) do
  dofile(spec)
end

print("project_profile_manager_spec: ok")
