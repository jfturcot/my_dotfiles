return {
  {
    "folke/persistence.nvim",
    init = function()
      local stdin = false
      vim.api.nvim_create_autocmd("StdinReadPre", {
        once = true,
        callback = function()
          stdin = true
        end,
      })
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          if stdin or vim.fn.argc() > 0 or vim.v.this_session ~= "" then
            return
          end
          vim.schedule(function()
            -- Restore this directory's session after the startup dashboard loads.
            require("persistence").load()
          end)
        end,
      })
    end,
  },
}
