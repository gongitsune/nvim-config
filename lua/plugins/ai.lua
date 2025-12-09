return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = vim.fn.has("unix") == 1 and "<M-l>" or "¬"
        }
      }
    }
  }
}
