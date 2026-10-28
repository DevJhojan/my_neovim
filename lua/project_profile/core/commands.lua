-- Comandos de usuario de acceso directo para elegir o limpiar el perfil.
-- Este módulo registra los comandos de Neovim y delega la lógica a otros módulos.

local repository = require("project_profile.core.repository")

local M = {}

-- Registra los comandos para seleccionar y limpiar el perfil del repositorio actual.
function M.setup(manager)
  vim.api.nvim_create_user_command("ProjectProfileSelect", function()
    manager.prompt_for_profile()
  end, {
    desc = "Selecciona el perfil para el repositorio actual",
  })

  vim.api.nvim_create_user_command("ProjectProfileClear", function()
    repository.clear_repo_profile(vim.fn.getcwd())
    vim.notify("Project profile cleared for this repository", vim.log.levels.INFO)
  end, {
    desc = "Limpia el perfil guardado para el repositorio actual",
  })
end

return M
