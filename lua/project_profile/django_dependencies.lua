local M = {}

local function has_django_stubs(path)
  local file = io.open(path, "r")
  if not file then
    return false
  end

  for line in file:lines() do
    local name = line:match("^%s*([%w_.-]+)")
    if name and name:lower():gsub("_", "-") == "django-stubs" then
      file:close()
      return true
    end
  end

  file:close()
  return false
end

function M.ensure_requirements(project_root, python)
  local requirements_path = project_root .. "/requirements.txt"
  if not has_django_stubs(requirements_path) then
    local file = assert(io.open(requirements_path, "a"))
    file:write("django-stubs\n")
    file:close()
  end

  vim.fn.system({ python, "-m", "pip", "install", "django-stubs" })
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to install django-stubs in " .. project_root, vim.log.levels.ERROR)
  end
end

return M
