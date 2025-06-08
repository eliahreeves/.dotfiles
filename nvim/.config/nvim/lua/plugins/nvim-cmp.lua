-- return {
--     "hrsh7th/nvim-cmp",
--     event = "VeryLazy",
--     dependencies = {
--         "hrsh7th/cmp-nvim-lsp",
--     },
--     config = function()
--         local cmp = require("cmp")
--         cmp.setup({
--             mapping = cmp.mapping.preset.insert({
--                 ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--                 ["<C-f>"] = cmp.mapping.scroll_docs(4),
--                 ["<C-e>"] = cmp.mapping.abort(),
--                 ["<CR>"] = cmp.mapping.confirm({ select = true }),
--             }),
--             snippet = {
--                 expand = function(args)
--                     require("luasnip").lsp_expand(args.body)
--                 end,
--             },
--             sources = cmp.config.sources({
--                 { name = "nvim_lsp" },
--                 { name = "luasnip" },
-- 								{ name = "path" },
--             }, {
--                 { name = "buffer" },
--             }),
--         })
--     end,
-- }

return {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer", -- Added buffer source
        "hrsh7th/cmp-path", -- Ensure path source works
        "L3MON4D3/LuaSnip", -- Required for luasnip to function
        "saadparwaiz1/cmp_luasnip", -- Completion for luasnip
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
            }),
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                {
                    name = "buffer",
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
            }),
        })
    end,
}
