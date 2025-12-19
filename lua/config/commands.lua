-- Highlight when yanking (copying) text.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})


local function exists_floating_window()
    for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).relative ~= '' then
            return true
        end
    end
    return false
end

-- Show floating window diagnostic on cursor hold
vim.api.nvim_create_autocmd('CursorHold', {
    callback = function ()
        -- Only show diagnostic window if there is no other floating window (e.g. lsp hover)
        if not exists_floating_window() then
            vim.diagnostic.open_float()
        end
    end
})

-- Hide diagnostics when in Insert mode
vim.api.nvim_create_autocmd('InsertEnter', {
    callback = function ()
        vim.diagnostic.hide()
    end
})

-- Show diagnostics again when exiting insert mode
vim.api.nvim_create_autocmd('InsertLeave', {
    callback = function ()
        vim.diagnostic.show()
    end
})
