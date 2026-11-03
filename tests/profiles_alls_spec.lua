-- Punto de entrada de las pruebas de todos los perfiles.
-- Mantiene las expectativas independientes de producción y delega guardar y
-- restaurar en archivos con una única responsabilidad cada uno.

local manager = require("project_profile.manager")
local verify_save = dofile("tests/save_profile_spec.lua")
local verify_restore = dofile("tests/restore_profile_manager.lua")

local profiles = {
  { name = "python", completion = "pyright", theme = { yellow = 60, blue = 30, white = 10 } },
  { name = "django", completion = "django", theme = { orange = 60, green = 30, white = 10 } },
  { name = "typescript", completion = "ts_ls", theme = { blue = 60, cyan = 30, white = 10 } },
  { name = "react", completion = "ts_ls", theme = { blue = 60, lime = 30, white = 10 } },
  { name = "react-native", completion = "ts_ls", theme = { blue = 60, purple = 30, white = 10 } },
  { name = "bash", completion = "bashls", theme = { ["#16141F"] = 60, ["#E0DEF4"] = 30, ["#9CCFD8"] = 10 } },
  { name = "rust", completion = "rust_analyzer", theme = { ["#0F1A2B"] = 60, ["#EDE6D6"] = 30, ["#F74C3C"] = 10 } },
  { name = "godot", completion = "gdscript", theme = {
    background = "#141B26",
    background_proportion = 60,
    foreground = "#E3EAF2",
    foreground_proportion = 30,
    keyword = "#5FD4F4",
    keyword_proportion = 10,
  } },
}

for _, profile in ipairs(profiles) do
  verify_save(profile)
  verify_restore(profile)
end

-- Comprueba que elegir otro perfil sustituya la selección anterior.
local replacements = {
  { previous = "django", selected = "typescript", completion = "ts_ls", theme = { cyan = 30 } },
  { previous = "typescript", selected = "django", completion = "django", theme = { orange = 60 } },
  { previous = "react", selected = "typescript", completion = "ts_ls", theme = { cyan = 30 } },
  { previous = "react-native", selected = "typescript", completion = "ts_ls", theme = { cyan = 30 } },
  { previous = "bash", selected = "typescript", completion = "ts_ls", theme = { cyan = 30 } },
  { previous = "rust", selected = "django", completion = "django", theme = { orange = 60 } },
  { previous = "godot", selected = "django", completion = "django", theme = { orange = 60 } },
}
for index, case in ipairs(replacements) do
  local repo_path = "/tmp/profile-replacement-spec-" .. index
  manager.clear_repo_profile(repo_path)
  manager.set_profile(case.previous, repo_path)
  manager.set_profile(case.selected, repo_path)
  assert(manager.get_profile(repo_path) == case.selected, "expected new profile to replace previous")
  assert(vim.g.project_profile == case.selected, "expected replacement profile to become active")
  assert(vim.g.project_profile_completion == case.completion, "expected replacement completion to become active")
  for color, proportion in pairs(case.theme) do
    assert(vim.g.project_profile_theme[color] == proportion, "expected replacement theme to become active")
  end
  manager.clear_repo_profile(repo_path)
end

-- Comprueba que Godot activa GDScript y aplica la paleta a los grupos reales de resaltado.
local original_cwd_godot = vim.fn.getcwd()
local godot_repo_path = "/tmp/godot-profile-activation-spec"
manager.clear_repo_profile(godot_repo_path)
vim.fn.mkdir(godot_repo_path, "p")
vim.cmd("cd " .. vim.fn.fnameescape(godot_repo_path))
manager.set_profile("godot", godot_repo_path)
assert(vim.g.project_profile_completion == "gdscript", "expected GDScript completion provider")
local normal_highlights = vim.api.nvim_get_hl(0, { name = "Normal" })
local keyword_highlights = vim.api.nvim_get_hl(0, { name = "Keyword" })
assert(normal_highlights.bg == 0x141B26, "expected Godot background color")
assert(normal_highlights.fg == 0xE3EAF2, "expected Godot foreground color")
assert(keyword_highlights.fg == 0x5FD4F4, "expected Godot keyword accent")
manager.clear_repo_profile(godot_repo_path)
vim.cmd("cd " .. vim.fn.fnameescape(original_cwd_godot))

-- Comprueba que Neovim reconoce GDScript/escenas, tiene sintaxis y habilita su LSP.
assert(vim.filetype.match({ filename = "script.gd" }) == "gdscript", "expected GDScript filetype")
assert(vim.filetype.match({ filename = "scene.tscn" }) == "gdresource", "expected scene filetype")
assert(vim.filetype.match({ filename = "resource.tres" }) == "gdresource", "expected resource filetype")
assert(#vim.api.nvim_get_runtime_file("syntax/gdscript.vim", false) > 0, "expected GDScript syntax support")
assert(#vim.api.nvim_get_runtime_file("syntax/gdresource.vim", false) > 0, "expected Godot scene syntax support")
assert(vim.lsp.is_enabled("gdscript"), "expected GDScript language server to be enabled")

-- Comprueba que el perfil predeterminado aplique la identidad cyberpunk roja cuando no hay un repositorio guardado.
local original_cwd_default = vim.fn.getcwd()
local default_repo_path = "/tmp/default-profile-cyberpunk-spec"
manager.clear_repo_profile(default_repo_path)
vim.fn.mkdir(default_repo_path, "p")
vim.cmd("cd " .. vim.fn.fnameescape(default_repo_path))
manager.set_profile("default", default_repo_path)
local normal_default = vim.api.nvim_get_hl(0, { name = "Normal" })
local keyword_default = vim.api.nvim_get_hl(0, { name = "Keyword" })
assert(normal_default.bg == 0x12070C, "expected default cyberpunk red background")
assert(normal_default.fg == 0xF4E6E6, "expected default cyberpunk red foreground")
assert(keyword_default.fg == 0xFF2E63, "expected default cyberpunk red accent")
manager.set_profile("react-native", default_repo_path)
assert(vim.g.colors_name == "catppuccin-mocha", "expected base colorscheme to be restored when leaving default")
manager.clear_repo_profile(default_repo_path)
vim.cmd("cd " .. vim.fn.fnameescape(original_cwd_default))

-- Comprueba que limpiar el perfil activo del repositorio restaure el perfil predeterminado.
local original_cwd = vim.fn.getcwd()
local clear_repo_path = "/tmp/profile-clear-active-spec"
manager.clear_repo_profile(clear_repo_path)
vim.fn.mkdir(clear_repo_path, "p")
vim.cmd("cd " .. vim.fn.fnameescape(clear_repo_path))
manager.set_profile("react-native", clear_repo_path)
manager.clear_repo_profile(clear_repo_path)
assert(vim.g.project_profile == "default", "expected default profile after clearing active profile")
assert(vim.g.project_profile_completion == "none", "expected default completion after clearing active profile")
assert(vim.g.project_profile_theme.background == "#12070C", "expected default cyberpunk background after clearing active profile")
assert(vim.g.project_profile_theme.foreground == "#F4E6E6", "expected default cyberpunk foreground after clearing active profile")
assert(vim.g.project_profile_theme.accent == "#FF2E63", "expected default cyberpunk accent after clearing active profile")
vim.cmd("cd " .. vim.fn.fnameescape(original_cwd))

print("profiles_alls_spec: ok")
