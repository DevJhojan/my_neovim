package.path = package.path .. ';lua/?.lua;tests/?.lua'

local project_profile = require('project_profile')
local project_repo = require('support.project_repo')

local function assert_equal(actual, expected, message)
  if actual ~= expected then
    error((message or 'Assertion failed') .. ': expected ' .. tostring(expected) .. ', got ' .. tostring(actual), 2)
  end
end

local function guarda_y_consulta_perfil_generico()
  local repo_path = '/tmp/project-with-python-first-save-' .. tostring(os.time()) .. '-' .. tostring(math.random(1000, 9999))

  assert_equal(project_profile.get_profile(repo_path), nil, 'get_profile should be nil before any profile is saved')

  local saved_profile = project_profile.save_profile(repo_path, 'custom-profile')
  assert_equal(saved_profile, 'custom-profile', 'save_profile should return the selected profile name')
  assert_equal(project_profile.get_profile(repo_path), 'custom-profile', 'get_profile should return the saved profile for the repo')
end

local function mantiene_perfil_en_repo_normal()
  local repo_path = project_repo.create()

  project_profile.save_profile(repo_path, 'python')

  assert_equal(project_profile.get_profile(repo_path), 'python', 'get_profile should return the profile saved in a normal repo')
end

local function mantiene_perfil_en_worktree()
  local repo_path = project_repo.create_worktree()

  local saved_profile = project_profile.save_profile(repo_path, 'python')
  assert_equal(saved_profile, 'python', 'save_profile should return the selected profile name for a worktree repo')
  assert_equal(project_profile.get_profile(repo_path), 'python', 'get_profile should return the saved profile for a worktree repo')
end

local function actualiza_asociacion_al_reseleccionar()
  local repo_path = '/tmp/project-with-python-update-' .. tostring(os.time()) .. '-' .. tostring(math.random(1000, 9999))

  project_profile.save_profile(repo_path, 'python')
  local updated_profile = project_profile.save_profile(repo_path, 'python3')

  assert_equal(updated_profile, 'python3', 'save_profile should return the latest selected profile name')
  assert_equal(project_profile.get_profile(repo_path), 'python3', 'get_profile should return the latest profile after reselecting it')
end

guarda_y_consulta_perfil_generico()
mantiene_perfil_en_repo_normal()
mantiene_perfil_en_worktree()
actualiza_asociacion_al_reseleccionar()
print('PASS: guarda_y_consulta_perfil_generico')
print('PASS: mantiene_perfil_en_repo_normal')
print('PASS: mantiene_perfil_en_worktree')
print('PASS: actualiza_asociacion_al_reseleccionar')
