return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
        scratch = { ft = "markdown" },
        dashboard = {
            preset = {
                header = require("config.header").random_header(),
				-- stylua: ignore
				---@type snacks.dashboard.Item[]
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
					{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
            },
        },
        picker = {
            ui_select = true,
            enabled = true,
            hidden = true,
            ignored = true,
            layouts = {
                select = {
                    layout = { relative = "cursor" }, -- pop at cursor
                },
            },
        },
        indent = { enabled = true },
        scroll = { enabled = true },
        image = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        bigfile = { enabled = true },
    },

    keys = {
        -- Scratch
        {
            "<leader>.",
            function()
                Snacks.scratch()
            end,
            desc = "Toggle Scratch Buffer",
        },
        {
            "<leader>S",
            function()
                Snacks.scratch.select()
            end,
            desc = "Select Scratch Buffer",
        },
        -- Picker
        {
            "<leader>uC",
            function()
                Snacks.picker.colorschemes({
                    -- finder = "vim_colorschemes",
                    -- format = "text",
                    -- preview = "colorscheme",
                    -- preset = "vertical",
                    confirm = function(picker, item)
                        picker:close()
                        if item then
                            picker.preview.state.colorscheme = nil
                            vim.schedule(function()
                                vim.cmd("colorscheme " .. item.text)
                            end)
                            local f = io.open(vim.fn.stdpath("config") .. "/last_colorscheme.vim", "w")
                            if f then
                                f:write("colorscheme " .. item.text .. "\n")
                                f:close()
                            end
                        end
                    end,
                })
            end,
            desc = "Colorschemes",
        },
        {
            "gr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        {
            "<leader><space>",
            function()
                Snacks.picker.smart()
            end,
            desc = "Smart Find Files",
        },
        {
            "<leader>,",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Search buffers",
        },
        {
            "<leader>/",
            function()
                Snacks.picker.grep()
            end,
            desc = "Search text",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Seach command history",
        },
        {
            "<leader>m",
            function()
                Snacks.picker.notifications()
            end,
            desc = "Search message history",
        },
        {
            "<leader>xx",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Search diagnostics",
        },
        {
            "<leader>xX",
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = "Search diagnostics (buffer)",
        },
        -- LazyGit
        {
            "<leader>gg",
            function()
                Snacks.lazygit()
            end,
            desc = "Lazygit",
        },
        -- Git Browse
        {
            "<leader>gB",
            function()
                Snacks.gitbrowse()
            end,
            desc = "Git Browse",
            mode = { "n", "v" },
        },
        -- -- Terminal
        -- {
        --     "<c-/>",
        --     function()
        --         Snacks.terminal.toggle()
        --     end,
        --     desc = "Toggle Terminal",
        -- },
    },
}
