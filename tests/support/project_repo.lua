local M = {}

local function unique_path(name)
  return '/tmp/project-profile-' .. name .. '-' .. tostring(os.time()) .. '-' .. tostring(math.random(1000, 9999))
end

function M.create()
  local repo_path = unique_path('repo')
  os.execute("mkdir -p '" .. repo_path .. "/.git'")
  return repo_path
end

function M.create_worktree()
  local repo_path = unique_path('worktree')
  local git_dir = unique_path('gitdir')

  os.execute("mkdir -p '" .. repo_path .. "'")
  os.execute("mkdir -p '" .. git_dir .. "'")

  local gitfile = assert(io.open(repo_path .. '/.git', 'w'))
  gitfile:write('gitdir: ' .. git_dir .. '\n')
  gitfile:close()

  return repo_path
end

return M
