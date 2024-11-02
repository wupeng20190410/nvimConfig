return{
    "nvim-treesitter/nvim-treesitter",
    config = function ()
        require("nvim-treesitter.configs").setup({
        ensure_installed = {"c" , "lua" , "asm"},

        highlight = { enable = true },
        incremental_selection = { enable = true },
        textobjects = { enable = true },
        })
        
    end
}
