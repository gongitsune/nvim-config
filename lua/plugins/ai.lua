return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = vim.fn.has("mac") == 0 and "<M-l>" or "¬"
        }
      }
    }
  }
}
