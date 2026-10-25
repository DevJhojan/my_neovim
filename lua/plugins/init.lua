-- ~/.config/nvim/lua/plugins/init.lua
return {
  -- Puedes colocar aquí plugins adicionales o dejarlo listo para importar otros archivos
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
