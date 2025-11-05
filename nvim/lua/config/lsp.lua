-- Custom LSP servers using native Neovim vim.lsp.config API
-- These are independent of nvim-lspconfig plugin

-- ============================================================================
-- GLOBAL LSP SETTINGS
-- ============================================================================

-- Keymaps for LSP functionality
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "hover" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "go to implementation" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "rename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code actions" })
vim.keymap.set("n", "<leader>ce", vim.diagnostic.open_float, { desc = "open error float" })

-- Diagnostic configuration
vim.diagnostic.config({
    signs = false,
    virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
    },
    severity_sort = true,
    float = {
        border = "rounded",
    },
    underline = true,
    update_in_insert = false,
})
-- ============================================================================
-- SLANG SERVER (SystemVerilog/Verilog)
-- ============================================================================
vim.lsp.config.slang_server = {
    cmd = { "slang-server" },
    filetypes = { "verilog", "systemverilog" },
    root_dir = function(bufnr)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        if fname == "" then
            return nil
        end

        -- First try to find .slang-server.json
        local found = vim.fs.find(".slang-server.json", { path = fname, upward = true })[1]
        if found then
            return vim.fs.dirname(found)
        end

        -- Fall back to .git
        found = vim.fs.find(".git", { path = fname, upward = true })[1]
        if found then
            return vim.fs.dirname(found)
        end

        -- Last resort: use the file's directory
        return vim.fs.dirname(fname)
    end,
    single_file_support = true,
    on_attach = function(client, bufnr)
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end,
    capabilities = vim.lsp.protocol.make_client_capabilities(),
}

vim.lsp.enable("slang_server")

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "verilog", "systemverilog" },
    callback = function(args)
        local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "slang_server" })
        if #clients == 0 then
            vim.lsp.start({
                name = "slang_server",
                cmd = { "slang-server" },
                root_dir = vim.lsp.config.slang_server.root_dir(args.buf),
            })
        end
    end,
})
-- -- ============================================================================
-- -- VTSLS (TypeScript/JavaScript)
-- -- ============================================================================
-- vim.lsp.config.vtsls = {
--     cmd = { "vtsls", "--stdio" },
--     filetypes = {
--         "javascript",
--         "javascriptreact",
--         "javascript.jsx",
--         "typescript",
--         "typescriptreact",
--         "typescript.tsx",
--         "vue",
--     },
--     root_dir = function(bufnr)
--         local fname = vim.api.nvim_buf_get_name(bufnr)
--         if fname == "" then
--             return nil
--         end

--         -- Try to find package.json, tsconfig.json, or .git
--         local found = vim.fs.find({ "package.json", "tsconfig.json", ".git" }, { path = fname, upward = true })[1]
--         if found then
--             return vim.fs.dirname(found)
--         end
--         return vim.fs.dirname(fname)
--     end,
-- }

-- -- Auto-start vtsls for TypeScript/JavaScript files
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
--     callback = function(args)
--         local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "vtsls" })
--         if #clients == 0 then
--             vim.lsp.start({
--                 name = "vtsls",
--                 cmd = vim.lsp.config.vtsls.cmd,
--                 root_dir = vim.lsp.config.vtsls.root_dir(args.buf),
--             })
--         end
--     end,
-- })
-- vim.lsp.enable("vtsls")

-- ============================================================================
-- PYRIGHT (Python with UV support)
-- ============================================================================

-- -- Helper function to find UV virtual environment
-- local function find_uv_venv()
--     -- Check for .venv in current directory first
--     local cwd = vim.fn.getcwd()
--     local venv_path = cwd .. "/.venv"
--     if vim.fn.isdirectory(venv_path) == 1 then
--         return venv_path .. "/bin/python"
--     end

--     -- Check for UV project virtual environment
--     local handle = io.popen("uv python find 2>/dev/null")
--     if handle then
--         local python_path = handle:read("*l")
--         handle:close()
--         if python_path and python_path ~= "" then
--             return python_path
--         end
--     end

--     return nil
-- end

-- vim.lsp.config.pyright = {
--     cmd = { "pyright-langserver", "--stdio" },
--     filetypes = { "python" },
--     root_dir = function(bufnr)
--         local fname = vim.api.nvim_buf_get_name(bufnr)
--         if fname == "" then
--             return nil
--         end

--         local found = vim.fs.find(
--             { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
--             { path = fname, upward = true }
--         )[1]
--         if found then
--             return vim.fs.dirname(found)
--         end
--         return vim.fs.dirname(fname)
--     end,
--     settings = {
--         python = {
--             pythonPath = find_uv_venv(),
--             analysis = {
--                 autoSearchPaths = true,
--                 useLibraryCodeForTypes = true,
--                 diagnosticMode = "workspace",
--                 typeCheckingMode = "basic",
--             },
--         },
--     },
-- }

-- -- Auto-start pyright for Python files
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "python" },
--     callback = function(args)
--         local clients = vim.lsp.get_clients({ bufnr = args.buf, name = "pyright" })
--         if #clients == 0 then
--             vim.lsp.start({
--                 name = "pyright",
--                 cmd = vim.lsp.config.pyright.cmd,
--                 root_dir = vim.lsp.config.pyright.root_dir(args.buf),
--                 settings = vim.lsp.config.pyright.settings,
--             })
--         end
--     end,
-- })
-- vim.lsp.enable("pyright")
