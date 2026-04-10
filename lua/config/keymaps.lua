-- Set <space> as the leader key
vim.g.mapleader = ' '

-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- Use jj to exit insert mode
vim.keymap.set('i', 'jj', '<Esc>')

-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Swap between buffers
vim.keymap.set('n', '<leader>bn', ':bnext<CR>')
vim.keymap.set('n', '<leader>bp', ':bprev<CR>')

-- Jump to definition
vim.keymap.set('n', 'gd', vim.lsp.buf.definition) -- Open in current window
vim.keymap.set('n', 'gsd', function () -- Open in horizontal split
    vim.cmd('split')
    vim.lsp.buf.definition()
end)
vim.keymap.set('n', 'gvd', function () -- Open in vertical split
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
end)

-- Jump to declaration
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration) -- Open in current window
vim.keymap.set('n', 'gsD', function () -- Open in horizontal split
    vim.cmd('split')
    vim.lsp.buf.declaration()
end)
vim.keymap.set('n', 'gvD', function () -- Open in vertical split
    vim.cmd('vsplit')
    vim.lsp.buf.declaration()
end)

-- Jump to implementation
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation) -- Open in current window
vim.keymap.set('n', 'gsI', function () -- Open in horizontal split
    vim.cmd('split')
    vim.lsp.buf.implementation()
end)
vim.keymap.set('n', 'gvI', function () -- Open in vertical split
    vim.cmd('vsplit')
    vim.lsp.buf.implementation()
end)

-- Jump to type definition
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition) -- Open in current window
vim.keymap.set('n', 'gsy', function () -- Open in horizontal split
    vim.cmd('split')
    vim.lsp.buf.type_definition()
end)
vim.keymap.set('n', 'gvy', function () -- Open in vertical split
    vim.cmd('vsplit')
    vim.lsp.buf.type_definition()
end)

vim.keymap.set('n', 'gr', vim.lsp.buf.references)

vim.keymap.set('n', 'K', function ()
    vim.lsp.buf.hover({
        border = "rounded",
    })
end)

vim.keymap.set('n', 'gK', vim.lsp.buf.signature_help)
vim.keymap.set('i', '<c-k>', vim.lsp.buf.signature_help)

vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)

