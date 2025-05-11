local M = {}

function M.get()
  if M._keys then
    return M._keys
  end

  M._keys = {
    {
      "<leader>ll",
      function()
        Snacks.picker.lsp_config()
      end,
      desc = "Lsp Info",
    },
    { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
    { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
    { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
    { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    {
      "K",
      function()
        return vim.lsp.buf.hover()
      end,
      desc = "Hover",
    },
    {
      "gK",
      function()
        return vim.lsp.buf.signature_help()
      end,
      desc = "Signature Help",
      has = "signatureHelp",
    },
    {
      "<c-k>",
      function()
        return vim.lsp.buf.signature_help()
      end,
      mode = "i",
      desc = "Signature Help",
      has = "signatureHelp",
    },
    {
      "<leader>la",
      require("actions-preview").code_actions,
      desc = "Code Action",
      mode = { "n", "v" },
      has = "codeAction",
    },
    { "<leader>lc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
    { "<leader>lC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
    {
      "<leader>lR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
      mode = { "n" },
      has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
    },
    { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      has = "documentHighlight",
      desc = "Next Reference",
      cond = function()
        return Snacks.words.is_enabled()
      end,
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      has = "documentHighlight",
      desc = "Prev Reference",
      cond = function()
        return Snacks.words.is_enabled()
      end,
    },
    {
      "<a-n>",
      function()
        Snacks.words.jump(vim.v.count1, true)
      end,
      has = "documentHighlight",
      desc = "Next Reference",
      cond = function()
        return Snacks.words.is_enabled()
      end,
    },
    {
      "<a-p>",
      function()
        Snacks.words.jump(-vim.v.count1, true)
      end,
      has = "documentHighlight",
      desc = "Prev Reference",
      cond = function()
        return Snacks.words.is_enabled()
      end,
    },
  }

  return M._keys
end

---@param buffer integer?
---@param method string|string[]
function M.has(buffer, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(buffer, m) then
        return true
      end
    end
    return false
  end
  method = method:find("/") and method or "textDocument/" .. method
  local clients = vim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client:supports_method(method, buffer) then
      return true
    end
  end
  return false
end

---@param buffer integer
function M.on_attach(buffer)
  local wk = require("which-key")

  for _, keys in pairs(M.get()) do
    local has = not keys.has or M.has(buffer, keys.has)
    local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

    if has and cond then
      wk.add({
        keys[1],
        keys[2],
        desc = keys.desc,
        mode = keys.mode,
        buffer = buffer,
      })
    end
  end
end

return M
