package.path = package.path .. ';' .. 'lua/?.lua'

local project_profile = require('project_profile')

local function assert_equal(actual, expected, message)
  if actual ~= expected then
    error((message or 'Assertion failed') .. ': expected ' .. tostring(expected) .. ', got ' .. tostring(actual), 2)
  end
end

local repo_path = '/tmp/project-with-python'

local saved_profile = project_profile.save_profile(repo_path, 'python')
assert_equal(saved_profile, 'python', 'save_profile should return the selected profile name')
assert_equal(project_profile.get_profile(repo_path), 'python', 'get_profile should return the saved profile for the repo')

print('PASS: project_profile_spec')
