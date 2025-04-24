vim.lsp.config("*", {
  capabilities = require('blink.cmp').get_lsp_capabilities()
})

vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
