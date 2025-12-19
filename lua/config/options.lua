-- Print the line number in front of each line
vim.o.number = true

-- Use relative line numbers, so that it is easier to jump with j, k. This will affect the 'number'
vim.o.relativenumber = true

-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight the line where the cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10
vim.o.wrap = false

-- Show <tab> and trailing spaces
vim.o.list = true

-- Use 2 spaces for tabs
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s) See `:help 'confirm'`
vim.o.confirm = true

-- Always show signcolumn (for diagnostics)
vim.o.signcolumn = "yes"

vim.o.updatetime = 750
-- vim.o.timeoutlen = 300 -- Controls time to use keybinds

vim.o.splitright = true
vim.o.splitbelow = true

