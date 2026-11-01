-- ~/.config/nvim/lua/plugins/gitsigns.lua
return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add          = { text = "┃" },
        change       = { text = "┃" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Atajos útiles de navegación y control de Git con la tecla líder (<leader>)
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "Siguiente cambio de Git (Hunk)" })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "Anterior cambio de Git (Hunk)" })

        -- Acciones rápidas sobre los cambios
        map('n', '<leader>hs', gs.stage_hunk, { desc = "Git: Agregar (stage) cambio actual" })
        map('n', '<leader>hr', gs.reset_hunk, { desc = "Git: Revertir cambio actual" })
        map('n', '<leader>hp', gs.preview_hunk, { desc = "Git: Vista previa del cambio" })
        map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Git: Ver blame de la línea" })
      end
    })
  end
}
