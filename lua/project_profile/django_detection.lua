local M = {}
local notified_projects = {}
local dependencies = require("project_profile.django_dependencies")

local function find_django_root(path)
  local current_dir = vim.fn.fnamemodify(path, ":p:h")

  while true do
    if vim.fn.filereadable(current_dir .. "/manage.py") == 1 then
      return current_dir
    end

    local parent_dir = vim.fn.fnamemodify(current_dir, ":h")
    if parent_dir == current_dir then
      return nil
    end
    current_dir = parent_dir
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("ProjectProfileDjangoDetection", { clear = true })

  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    callback = function(event)
      local project_root = find_django_root(vim.api.nvim_buf_get_name(event.buf))
      if project_root and not notified_projects[project_root] then
        notified_projects[project_root] = true
        vim.notify("Django project detected: " .. project_root)
        local python = project_root .. "/.venv/bin/python"
        if vim.fn.executable(python) == 1 then
          dependencies.ensure_dependencies(project_root, python)
        else
          python = project_root .. "/venv/bin/python"
          if vim.fn.executable(python) == 1 then
            dependencies.ensure_dependencies(project_root, python)
          else
            vim.notify("No project virtual environment found for " .. project_root, vim.log.levels.WARN)
          end
        end
      end
    end,
  })
end

return M
