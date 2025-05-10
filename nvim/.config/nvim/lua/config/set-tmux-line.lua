local M = {}
function M.UpdateTmuxLine()
    if os.getenv("TMUX") then
        local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
        if bg then
            local hex = string.format("#%06x", bg)
            os.execute("tmux set-option status-style 'bg=" .. hex .. "' >/dev/null 2>&1")
        end
    end
end
return M
