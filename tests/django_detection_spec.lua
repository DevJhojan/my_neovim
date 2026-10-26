local project_root = vim.fn.tempname()
vim.fn.mkdir(project_root .. "/app", "p")

local manage_file = assert(io.open(project_root .. "/manage.py", "w"))
manage_file:write("")
manage_file:close()

local source_file = assert(io.open(project_root .. "/app/views.py", "w"))
source_file:write("")
source_file:close()

package.path = package.path .. ";lua/?.lua"
local django_detection = require("project_profile.django_detection")
local notified_message
vim.notify = function(message)
  notified_message = message
end

django_detection.setup()
vim.cmd("edit " .. vim.fn.fnameescape(project_root .. "/app/views.py"))

assert(notified_message, "opening a project containing manage.py should notify that Django was recognized")
print("PASS: reconoce_proyecto_django_con_manage_py")

local python_root = vim.fn.tempname()
vim.fn.mkdir(python_root, "p")
notified_message = nil
vim.cmd("edit " .. vim.fn.fnameescape(python_root .. "/script.py"))

assert(notified_message == nil, "opening a project without manage.py should not notify that Django was recognized")
print("PASS: no_notifica_proyecto_como_django_sin_manage_py")

local dependency_root = vim.fn.tempname()
vim.fn.mkdir(dependency_root .. "/.venv/bin", "p")
local dependency_manage_file = assert(io.open(dependency_root .. "/manage.py", "w"))
dependency_manage_file:write("")
dependency_manage_file:close()
local requirements_file = assert(io.open(dependency_root .. "/requirements.txt", "w"))
requirements_file:write("Django\n")
requirements_file:close()
local fake_python = assert(io.open(dependency_root .. "/.venv/bin/python", "w"))
fake_python:close()
local install_command
local original_executable = vim.fn.executable
vim.fn.executable = function(path)
  if path == dependency_root .. "/.venv/bin/python" then
    return 1
  end
  return original_executable(path)
end
vim.fn.system = function(command)
  install_command = command
  return ""
end
vim.cmd("edit " .. vim.fn.fnameescape(dependency_root .. "/manage.py"))

local updated_requirements = assert(io.open(dependency_root .. "/requirements.txt", "r")):read("*a")
assert(updated_requirements:match("django%-stubs"), "Django requirements should declare django-stubs")
assert(install_command, "Django dependencies should be installed")
assert(install_command[1] == dependency_root .. "/.venv/bin/python", "installation should use the project virtualenv")
print("PASS: declara_e_instala_django_stubs_en_requirements")

local pyproject_root = vim.fn.tempname()
vim.fn.mkdir(pyproject_root .. "/.venv/bin", "p")
local pyproject_manage_file = assert(io.open(pyproject_root .. "/manage.py", "w"))
pyproject_manage_file:write("")
pyproject_manage_file:close()
local pyproject_file = assert(io.open(pyproject_root .. "/pyproject.toml", "w"))
pyproject_file:write('[project]\nname = "sample"\n')
pyproject_file:close()
vim.fn.executable = function(path)
  if path == pyproject_root .. "/.venv/bin/python" then
    return 1
  end
  return original_executable(path)
end
install_command = nil
vim.cmd("edit " .. vim.fn.fnameescape(pyproject_root .. "/manage.py"))

local updated_pyproject = assert(io.open(pyproject_root .. "/pyproject.toml", "r")):read("*a")
assert(updated_pyproject:match('dependencies%s*=%s*%["django%-stubs"%]'), "PEP 621 dependencies should declare django-stubs")
assert(install_command, "Django dependencies should be installed for pyproject projects")
assert(install_command[1] == pyproject_root .. "/.venv/bin/python", "installation should use the pyproject virtualenv")
print("PASS: declara_django_stubs_en_pyproject_pep621")

local existing_pyproject_root = vim.fn.tempname()
vim.fn.mkdir(existing_pyproject_root .. "/.venv/bin", "p")
local existing_manage_file = assert(io.open(existing_pyproject_root .. "/manage.py", "w"))
existing_manage_file:write("")
existing_manage_file:close()
local existing_pyproject_file = assert(io.open(existing_pyproject_root .. "/pyproject.toml", "w"))
existing_pyproject_file:write('[project]\nname = "sample"\ndependencies = ["django-stubs>=5"]\n')
existing_pyproject_file:close()
vim.fn.executable = function(path)
  if path == existing_pyproject_root .. "/.venv/bin/python" then
    return 1
  end
  return original_executable(path)
end
install_command = nil
vim.cmd("edit " .. vim.fn.fnameescape(existing_pyproject_root .. "/manage.py"))

local existing_pyproject = assert(io.open(existing_pyproject_root .. "/pyproject.toml", "r")):read("*a")
local _, stub_count = existing_pyproject:gsub("django%-stubs", "")
assert(stub_count == 1, "PEP 621 dependencies should not duplicate django-stubs")
assert(install_command, "existing Django dependencies should still be installed")
print("PASS: no_duplica_django_stubs_en_pyproject_pep621")

local both_root = vim.fn.tempname()
vim.fn.mkdir(both_root .. "/.venv/bin", "p")
local both_manage_file = assert(io.open(both_root .. "/manage.py", "w"))
both_manage_file:write("")
both_manage_file:close()
local both_requirements = assert(io.open(both_root .. "/requirements.txt", "w"))
both_requirements:write("Django\n")
both_requirements:close()
local both_pyproject = assert(io.open(both_root .. "/pyproject.toml", "w"))
both_pyproject:write('[project]\nname = "sample"\ndependencies = ["Django"]\n')
both_pyproject:close()
vim.fn.executable = function(path)
  if path == both_root .. "/.venv/bin/python" then
    return 1
  end
  return original_executable(path)
end
install_command = nil
vim.cmd("edit " .. vim.fn.fnameescape(both_root .. "/manage.py"))

local both_updated_requirements = assert(io.open(both_root .. "/requirements.txt", "r")):read("*a")
local both_updated_pyproject = assert(io.open(both_root .. "/pyproject.toml", "r")):read("*a")
assert(both_updated_requirements:match("django%-stubs"), "requirements.txt should declare django-stubs")
assert(both_updated_pyproject:match("django%-stubs"), "pyproject.toml should declare django-stubs")
print("PASS: actualiza_ambos_manifiestos_si_existen")
