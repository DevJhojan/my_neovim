-- Firma: @DevJhojan
-- ~/.config/nvim/lua/config/options.lua
local opt = vim.opt

opt.number = true          -- Mostrar números de línea
opt.relativenumber = true  -- Números de línea relativos (muy útil para saltos)
opt.expandtab = true       -- Convertir pestañas en espacios
opt.shiftwidth = 2         -- Tamaño de la indentación (espacios)
opt.tabstop = 2            -- Ancho de un carácter de tabulación
opt.smartindent = true     -- Indentación inteligente automática
opt.termguicolors = true   -- Habilitar colores verdaderos de 24 bits en la terminal
opt.cursorline = true      -- Resaltar la línea actual
opt.clipboard = "unnamedplus" -- Sincronizar con el portapapeles del sistema

vim.g.mapleader = " "
vim.g.maplocalleader = " "
