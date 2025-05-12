-- lua/plugins/init.lua
return {
  {
     "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "NvimTreeToggle",
  config = function()
    require("nvim-tree").setup()
  end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "omnisharp",
          "ts_ls",
          "gopls",
          "html",
          "cssls",
          "jsonls",
        },
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, lsp in ipairs({ "omnisharp", "ts_ls", "gopls", "html", "cssls", "jsonls" }) do
        if lsp == "omnisharp" then
          lspconfig.omnisharp.setup({
            capabilities = capabilities,
            cmd = {
              vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp",
              "--languageserver",
              "--hostPID",
              tostring(vim.fn.getpid()),
            },
          })
        else
          lspconfig[lsp].setup({ capabilities = capabilities })
        end
      end
    end,
  },
  require("plugins.completion"),
}
