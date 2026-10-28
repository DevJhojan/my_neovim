-- ~/.config/nvim/lua/config/keymaps.lua
vim.g.mapleader = " " -- Definir la tecla <leader> como la barra espaciadora

local keymap = vim.keymap.set

-- Guardar archivo rápido con <leader> + w
keymap("n", "<leader>w", ":w<CR>", { desc = "Guardar archivo" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Cerrar archivo" })
keymap("n", "<leader>p", ":ProjectProfileSelect<CR>", { desc = "Cerrar archivo" })
