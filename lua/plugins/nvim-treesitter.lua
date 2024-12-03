return{
    "nvim-treesitter/nvim-treesitter",
    config = function ()
        require("nvim-treesitter.configs").setup({
        ensure_installed = {"c" , "lua" , "asm" , "python"},

        highlight = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
        })
        
    end
}
