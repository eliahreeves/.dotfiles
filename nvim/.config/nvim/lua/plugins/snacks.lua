return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
        explorer = {},
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
            enabled = true,
            hidden = true,
            ignored = true,
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
                            require("config.set-tmux-line").UpdateTmuxLine()
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
