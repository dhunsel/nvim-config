require('config.options')
require('config.keymaps')
require('config.lazy')
require('config.commands')

vim.cmd.colorscheme "catppuccin"

vim.diagnostic.config({ 
    virtual_text = {
        prefix = "●",
        severity = {
            min = vim.diagnostic.severity.WARN
        },
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        scope = 'cursor',
        source = "if_many",
        border = "rounded",
        focusable = false,
        close_events = {
           'InsertEnter',
           'CursorMoved',
           'WinNew',
        }
    }
})

vim.lsp.enable('eslint')

-- Automatically turn off search highlighting after 'updatetime' and when going to insert mode
vim.cmd('packadd! nohlsearch')

