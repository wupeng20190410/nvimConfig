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
                -- Map "l" to open a file or folder
                vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
                -- Optionally map "h" to go up one level (close folder)
                vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
                vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
                vim.keymap.set('n','.',api.tree.change_root_to_node,opts('change_root_to_node'))
                vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
            end,
        })
    end
}
