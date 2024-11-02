return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function()
        vim.opt.termguicolors = true
        require("bufferline").setup({

            options = {
                hover = { enabled = true, delay = 200, reveal = { 'close' } },
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local icon = level:match("error") and " " or " "
                    return " " .. icon .. count
                end
            },
        })
    end
}
