return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
      enable_autocmd = false,
    }
  },
  {
    'numToStr/Comment.nvim',
    opts = function()
      local integration = require('ts_context_commentstring.integrations.comment_nvim')
      return {
        pre_hook = integration.create_pre_hook(),
      }
    end
  },
}
