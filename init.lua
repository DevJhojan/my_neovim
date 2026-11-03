-- Firma: @DevJhojan

-- Cargar opciones básicas y atajos antes de los plugins
require("config.options")
require("config.keymaps")
require("project_profile.manager").setup()

-- Bootstrap (instalación automática) de lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Inicializar lazy.nvim cargando los plugins desde la carpeta lua/plugins/
require("lazy").setup({
  { import = "plugins" },
}, {
  checker = { enabled = true, notify = false },
})
