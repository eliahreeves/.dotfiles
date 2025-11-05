return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            model = "gpt-4o",
            tools = "copilot",
            window = {
                layout = "vertical",
                width = 80, -- Fixed width in columns
                border = "rounded", -- 'single', 'double', 'rounded', 'solid'
                title = "🤖 AI Assistant (%s)",
                zindex = 100, -- Ensure window stays on top
            },

            headers = {
                user = "👤 You",
                assistant = "🤖 Copilot",
                tool = "🔧 Tool",
            },

            separator = "━━",
            auto_fold = true,
        },
        keys = {
            -- Start a new chat
            {
                "<leader>in",
                function()
                    require("CopilotChat").reset()
                end,
                desc = "CopilotChat: New Chat",
            },
            -- Choose model (if supported)
            {
                "<leader>im",
                function()
                    require("CopilotChat").select_model()
                end,
                desc = "CopilotChat: Choose Model",
            },
            {
                "<leader>ic",
                function()
                    require("CopilotChat").toggle()
                end,
                desc = "CopilotChat: Toggle Chat",
            },
        },
    },
}
