local M = {}

local function read_file(path)
  local file = io.open(path, "r")
  if not file then
    return nil
  end

  local content = file:read("*a")
  file:close()
  return content
end

local function contains_django_stubs(dependencies)
  for name in dependencies:gmatch("[\"']([^\"']+)[\"']") do
    local package = name:match("^%s*([%w_.-]+)")
    if package and package:lower():gsub("_", "-") == "django-stubs" then
      return true
    end
  end

  return false
end

local function ensure_pyproject(project_root)
  local path = project_root .. "/pyproject.toml"
  local content = read_file(path)
  if not content then
    return false
  end

  local project_start, project_end = content:find("%[project%][^\n]*\n")
  if not project_start then
    return false
  end
  project_end = content:find("\n%[", project_end + 1) or (#content + 1)
  local section = content:sub(project_start, project_end - 1)
  local key_start, array_start = section:find("dependencies%s*=%s*%[")
  if key_start then
    local array_end = section:find("%]", array_start + 1)
    if not array_end then
      error("Unsupported multiline dependencies array in " .. path)
    end
    local dependencies = section:sub(array_start + 1, array_end - 1)
    if contains_django_stubs(dependencies) then
      return true
    end

    local addition = dependencies:match("%S") and ', "django-stubs"' or '"django-stubs"'
    section = section:sub(1, array_end - 1) .. addition .. section:sub(array_end)
  else
    section = section .. 'dependencies = ["django-stubs"]\n'
  end

  local file = assert(io.open(path, "w"))
  file:write(content:sub(1, project_start - 1), section, content:sub(project_end))
  file:close()
  return true
end

function M.ensure_dependencies(project_root, python)
  local requirements_path = project_root .. "/requirements.txt"
  local requirements = read_file(requirements_path)
  if requirements then
    if not requirements:lower():match("django[-_]stubs") then
      local file = assert(io.open(requirements_path, "a"))
      file:write("django-stubs\n")
      file:close()
    end
  end
  ensure_pyproject(project_root)

  vim.fn.system({ python, "-m", "pip", "install", "django-stubs" })
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to install django-stubs in " .. project_root, vim.log.levels.ERROR)
  end
end

return M
