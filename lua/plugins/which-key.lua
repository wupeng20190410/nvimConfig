return{
  "folke/which-key.nvim",
  event = "VeryLazy",

    opts = function(_, opts)
    local wk = require("which-key")
    
    wk.add({
      { "<leader>c", group = "Codeium" },
      { 
        "<leader>cd", 
        function() 
          require("codeium.config").options.virtual_text.manual = true
          vim.notify("Codeium suggestions disabled", vim.log.levels.INFO)
        end, 
        desc = "Disable Codeium Suggestions" 
      },
      { 
        "<leader>ce", 
        function() 
          require("codeium.config").options.virtual_text.manual = false
          vim.notify("Codeium suggestions enabled", vim.log.levels.INFO)
        end, 
        desc = "Enable Codeium Suggestions" 
      },
      { 
        "<leader>cs", 
        function()
          vim.cmd('call codeium#Complete()')
        end, 
        desc = "Trigger Codeium Suggestion" 
      }
    })
  end
,
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
