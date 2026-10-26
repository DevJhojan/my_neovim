local M = {}

local function shell_quote(value)
  return "'" .. tostring(value):gsub("'", "'\"'\"'") .. "'"
end

local function store_path(repo_path)
  return tostring(repo_path):gsub("/+$", "") .. "/.git/project_profile"
end

function M.save_profile(repo_path, profile)
  if type(repo_path) ~= "string" or repo_path == "" then
    error("repo_path is required")
  end

  if type(profile) ~= "string" or profile == "" then
    error("profile must be a non-empty string")
  end

  local git_dir = tostring(repo_path):gsub("/+$", "") .. "/.git"
  os.execute("mkdir -p " .. shell_quote(git_dir))

  local file = assert(io.open(store_path(repo_path), "w"))
  file:write(profile)
  file:close()

  return profile
end

function M.get_profile(repo_path)
  if type(repo_path) ~= "string" or repo_path == "" then
    return nil
  end

  local file = io.open(store_path(repo_path), "r")
  if not file then
    return nil
  end

  local profile = file:read("*a"):gsub("%s+$", "")
  file:close()

  return profile ~= "" and profile or nil
end

return M
