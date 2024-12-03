return {
    "nvim-tree/nvim-tree.lua",
    config = function()
        require("nvim-tree").setup({
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")

                -- Helper function for key mappings
                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- custom mappings
                api.config.mappings.default_on_attach(bufnr)
                vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
                vim.keymap.set('n','.',api.tree.change_root_to_node,opts('change_root_to_node'))


            end,
        })
    end
}
