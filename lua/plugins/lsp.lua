return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
    opts = {
        autoformat = false,
    },
    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "asm_lsp",
                "clangd",
                "pylsp"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                },
                            },
                        },
                    })
                end,
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                --['<TAB>'] = cmp.mapping.select_prev_item(cmp_select),
                ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                -- ["<CR>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({

                { name = "nvim_lsp" }, -- For nvim-lsp
                { name = "luasnip" },  -- For luasnip user
                { name = "buffer" },   -- For buffer word completion
                { name = "path" },     -- For path completion
            }),
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        require("mason-lspconfig").setup({
            -- A list of servers to automatically install if they're not already installed.
            ensure_installed = { "pylsp", "lua_ls", "bashls", "clangd", "asm_lsp" },
        })

        -- Set different settings for different languages' LSP.
        -- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        -- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
        --     - the settings table is sent to the LSP.
        --     - on_attach: a lua callback function to run after LSP attaches to a given buffer.
        local lspconfig = require("lspconfig")

        -- Use an on_attach function to only map the following keys
        -- after the language server attaches to the current buffer.
        local on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

            if client.name == "rust_analyzer" then
                -- WARNING: This feature requires Neovim 0.10 or later.
                vim.lsp.inlay_hint.enable()
            end

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            vim.keymap.set(
                "n",
                "gD",
                vim.lsp.buf.declaration,
                { desc = "Go to declaration", noremap = true, silent = true, buffer = bufnr }
            )
            vim.keymap.set(
                "n",
                "gd",
                vim.lsp.buf.definition,
                { desc = "Go to definition", noremap = true, silent = true, buffer = bufnr }
            )
            vim.keymap.set(
                "n",
                "K",
                vim.lsp.buf.hover,
                { desc = "Hover information", noremap = true, silent = true, buffer = bufnr }
            )
            vim.keymap.set(
                "n",
                "gi",
                vim.lsp.buf.implementation,
                { desc = "Go to implementation", noremap = true, silent = true, buffer = bufnr }
            )
            vim.keymap.set(
                "n",
                "<C-k>",
                vim.lsp.buf.signature_help,
                { desc = "Signature help", noremap = true, silent = true, buffer = bufnr }
            )
            vim.keymap.set(
                "n",
                "<space>wa",
                vim.lsp.buf.add_workspace_folder,
                { desc = "Add wordspace folder", noremap = true, silent = true, buffer = bufnr }
            )
            vim.keymap.set(
                "n",
                "<space>wr",
                vim.lsp.buf.remove_workspace_folder,
                { desc = "Remove workspace folder", noremap = true, silent = true, buffer = bufnr }
            )
            vim.keymap.set("n", "<space>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, { desc = "List workspace folders", noremap = true, silent = true, buffer = bufnr })
            vim.keymap.set(
                "n",
                "<space>D",
                vim.lsp.buf.type_definition,
                { desc = "Go to type definition", noremap = true, silent = true, buffer = bufnr }
            )
            vim.keymap.set(
                "n",
                "<space>rn",
                vim.lsp.buf.rename,
                { desc = "Rename symbol", noremap = true, silent = true, buffer = bufnr }
            )
            vim.keymap.set(
                "n",
                "<space>ca",
                vim.lsp.buf.code_action,
                { desc = "Code action", noremap = true, silent = true, buffer = bufnr }
            )
            vim.keymap.set(
                "n",
                "gr",
                vim.lsp.buf.references,
                { desc = "Find references", noremap = true, silent = true, buffer = bufnr }
            )
            vim.keymap.set("n", "<space>f", function()
                vim.lsp.buf.format({
                    async = true,
                    -- Predicate used to filter clients. Receives a client as
                    -- argument and must return a boolean. Clients matching the
                    -- predicate are included.
                    filter = function(client)
                print("LSP client attached: " .. client.name)
                        -- NOTE: If an LSP contains a formatter, we don't need to use null-ls at all.
                        return   client.name == "null-ls" or client.name == "lua_ls" or client.name == "asm_lsp" or
                            client.name == "clangd" or client.name == "pylsp"
                    end,
                })
            end, { desc = "Format code", noremap = true, silent = true, buffer = bufnr })
        end

        -- How to add an LSP for a specific programming language?
        -- 1. Use `:Mason` to install the corresponding LSP.
        -- 2. Add the configuration below. The syntax is `lspconfig.<name>.setup(...)`
        -- Hint (find <name> here) : https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurationsGkkK.md
        lspconfig.pylsp.setup({
            on_attach = on_attach,
        })

        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim).
                        version = "LuaJIT",
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global.
                        globals = { "vim" },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files.
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier.
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        lspconfig.bashls.setup({})

        lspconfig.clangd.setup({
            on_attach = on_attach,
        })

        lspconfig.asm_lsp.setup({

            on_attach = on_attach,

        })
    end,
}
