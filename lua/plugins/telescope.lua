-- Firma: @DevJhojan
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local builtin = require("telescope.builtin")
    -- Atajos de teclado para Telescope
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Buscar archivos" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Buscar texto en proyecto" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Listar buffers abiertos" })
  end,
}
