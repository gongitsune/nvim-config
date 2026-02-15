vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
if vim.fn.has("mac") then
  vim.lsp.enable("sourcekit")
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local buffer = args.buf ---@type number
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      require("plugins.lsp.keymap").on_attach(buffer)
    end
  end,
})
