return {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    keys = {
        { "<Up>", mode = { "n", "x" } },
        { "<Down>", mode = { "n", "x" } },
        { "<Leader><Up>", mode = { "n", "x" } },
        { "<Leader><Down>", mode = { "n", "x" } },
        { "<C-LeftMouse>", mode = "n" },
        { "<C-LeftDrag>", mode = "n" },
        { "<C-LeftRelease>", mode = "n" },
        { "<Leader>uc", mode = { "n", "x" } },
        { "<Leader>n", mode = { "n", "x" } },
    },
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        set({ "n", "x" }, "<Up>", function()
            mc.lineAddCursor(-1)
        end)
        set({ "n", "x" }, "<Down>", function()
            mc.lineAddCursor(1)
        end)
        set({ "n", "x" }, "<Leader><Up>", function()
            mc.lineSkipCursor(-1)
        end)
        set({ "n", "x" }, "<Leader><Down>", function()
            mc.lineSkipCursor(1)
        end)
        set({ "n", "x" }, "<Leader>n", function()
            mc.matchAddCursor(1)
        end)
        -- set({ "n", "x" }, "<Leader>s", function()
        --     mc.matchSkipCursor(1)
        -- end)
        set({ "n", "x" }, "<Leader>N", function()
            mc.matchAddCursor(-1)
        end)
        -- set({ "n", "x" }, "<Leader>S", function()
        --     mc.matchSkipCursor(-1)
        -- end)

        set("n", "<C-LeftMouse>", mc.handleMouse)
        set("n", "<C-LeftDrag>", mc.handleMouseDrag)
        set("n", "<C-LeftRelease>", mc.handleMouseRelease)

        set({ "n", "x" }, "<Leader>uc", mc.toggleCursor)
        mc.addKeymapLayer(function(layerSet)
            layerSet({ "n", "x" }, "<Left>", mc.prevCursor)
            layerSet({ "n", "x" }, "<Right>", mc.nextCursor)
            layerSet({ "n", "x" }, "<Leader>x", mc.deleteCursor)
            layerSet("n", "<Esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn" })
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end,
}
