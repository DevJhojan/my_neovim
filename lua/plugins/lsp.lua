-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      
      -- Servidores LSP a instalar automáticamente
      local servers = {
        "pyright",       -- Python
        "ts_ls",         -- TypeScript / JavaScript (React y React Native)
        "bashls",        -- Bash
        "html",          -- HTML / JSX / TSX base
        "cssls",         -- CSS (para estilos en componentes React)
        "sqlls",         -- SQL general / MySQL
      }

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })

      -- Configuración moderna utilizando el nuevo estándar de Neovim para LSP
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      for _, server in ipairs(servers) do
        vim.lsp.config[server] = {
          capabilities = capabilities,
        }
        vim.lsp.enable(server)
      end
    end,
  },
}
