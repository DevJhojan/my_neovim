-- ~/.config/nvim/lua/config/transparency.lua (o directamente en tu init.lua)

local function toggle_transparency()
  local highlights = {
    "Normal",
    "NormalNC",
    "SignColumn",
    "EndOfBuffer",
    "LineNr",
    "CursorLineNr",
    "NvimTreeNormal", -- Si usas nvim-tree que instalamos antes
    "NvimTreeNormalNC",
  }

  for _, hl in ipairs(highlights) do
    vim.cmd(string.format("highlight %s guibg=NONE ctermbg=NONE", hl))
  end
end

-- Aplicar la transparencia al iniciar
toggle_transparency()

-- Opcional: Reaplicarla si cambias de esquema de colores en caliente
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = toggle_transparency,
})
