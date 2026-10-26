local M = {}

local function profile_path(git_dir)
  return git_dir .. "/project_profile"
end

function M.save(git_dir, profile)
  os.execute("mkdir -p '" .. git_dir:gsub("'", "'\"'\"'") .. "'")

  local file = assert(io.open(profile_path(git_dir), "w"))
  file:write(profile)
  file:close()
end

function M.get(git_dir)
  local file = io.open(profile_path(git_dir), "r")
  if not file then
    return nil
  end

  local profile = file:read("*a"):gsub("%s+$", "")
  file:close()

  return profile ~= "" and profile or nil
end

return M
