return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true })
            end,
            mode = "n",
            desc = "Format buffer",
        },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            nix = { "alejandra" },
            bash = { "shfmt" },
            go = { "gofumpt" },
            python = { "ruff" },
            rust = { "rustfmt" },
            json = { "jq" },
            markdown = { "injected" },
            tex = { "latexindent" },
            sql = { "sql_formatter" },
            -- verilog = { "verible-verilog-format" },
            -- systemverilog = { "verible-verilog-format" },
        },
        default_format_opts = {
            lsp_format = "fallback",
            tab_width = 4,
            use_tabs = false,
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500 },
        -- Customize formatters
        formatters = {
            shfmt = {
                prepend_args = { "-i", "2" },
            },
            sql_formatter = {
                args = { "--config", '{"language": "postgresql", "uppercase": true}' },
            },
            stylua = { prepend_args = { "--indent-type", "Spaces" } },
            ruff = { prepend_args = { "format" } },
            -- ["verible-verilog-format"] = {
            --     command = "verible-verilog-format",
            --     args = { "-" },
            --     -- args = { "--failsafe_=false" },
            -- },
        },
    },
    init = function()
        -- If you want the formatexpr, here is the place to set it
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
