local M = {}

local function shell_quote(value)
  return "'" .. tostring(value):gsub("'", "'\"'\"'") .. "'"
end

function M.resolve(repo_path)
  local base_path = tostring(repo_path):gsub("/+$", "")
  local git_path = base_path .. "/.git"

  if os.execute("test -d " .. shell_quote(git_path)) == 0 then
    return git_path
  end

  local git_file = io.open(git_path, "r")
  if not git_file then
    return git_path
  end

  local content = git_file:read("*a")
  git_file:close()

  if not content then
    return git_path
  end

  local gitdir = content:match("gitdir:%s*(.-)%s*$")
  if gitdir then
    if gitdir:sub(1, 1) ~= "/" then
      gitdir = base_path .. "/" .. gitdir
    end
    return gitdir:gsub("/+$", "")
  end

  return git_path
end

return M
