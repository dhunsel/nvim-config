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

vim.lsp.config('eslint', {
  cmd = { 'node', vim.fn.expand('~/.local/share/nvim/eslint-lsp/eslintServer.js'), '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
    'astro',
  },
})
vim.lsp.enable('eslint')

-- paths to check for project.godot file
local paths_to_check = {'/', '/../'}
local is_godot_project = false
local cwd = vim.fn.getcwd()

-- iterate over paths and check
for key, value in pairs(paths_to_check) do
    if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
        is_godot_project = true
        break
    end
end

-- check if server is already running in godot project path
local is_server_running = vim.uv.fs_stat('/tmp/godot.pipe')
-- start server, if not already running
if is_godot_project and not is_server_running then
    vim.fn.serverstart('/tmp/godot.pipe')
end

if is_godot_project then
    local port = os.getenv 'GDScript_Port' or '6005'
    local cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(port))

    vim.lsp.config('gdscript', {
      cmd = cmd,
      filetypes = { 'gdscript' },
      root_markers = { 'project.godot', '.git' },
    })

    vim.lsp.enable('gdscript')
end
