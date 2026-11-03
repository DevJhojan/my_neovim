-- Firma: @DevJhojan
-- ~/.config/nvim/lua/plugins/nvim-tree.lua
return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      hijack_netrw = false,
      sort_by = "case_sensitive",
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false, -- Muestra archivos ocultos (opcional)
      },
    })

    -- Asignar el comando <leader> + nt para alternar el árbol de directorios
    vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>", { silent = true, desc = "Alternar NvimTree" })
  end,
}
