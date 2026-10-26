local M = {}

local git_dir = require("project_profile.git_dir")
local storage = require("project_profile.storage")

function M.save_profile(repo_path, profile)
  if type(repo_path) ~= "string" or repo_path == "" then
    error("repo_path is required")
  end

  if type(profile) ~= "string" or profile == "" then
    error("profile must be a non-empty string")
  end

  storage.save(git_dir.resolve(repo_path), profile)

  return profile
end

function M.get_profile(repo_path)
  if type(repo_path) ~= "string" or repo_path == "" then
    return nil
  end

  return storage.get(git_dir.resolve(repo_path))
end

return M
