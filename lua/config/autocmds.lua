vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("SnacksPickerFix", { clear = true }),
  callback = function()
    -- ファイルタイプが設定されていない、かつファイル名が存在する場合
    if vim.bo.filetype == "" and vim.fn.bufname() ~= "" then
      -- ファイルタイプ検出を強制実行
      vim.cmd("filetype detect")
    end
  end,
})
