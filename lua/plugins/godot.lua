return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local paths_to_check = { '/', '/../' }
      local cwd = vim.fn.getcwd()
      local is_godot_project = false

      for _, value in pairs(paths_to_check) do
        if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
          is_godot_project = true
          break
        end
      end

      if not is_godot_project then return end

      if not vim.uv.fs_stat('/tmp/godot.pipe') then
        vim.fn.serverstart('/tmp/godot.pipe')
      end

      local port = os.getenv('GDScript_Port') or '6005'
      vim.lsp.config('gdscript', {
        cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(port)),
        filetypes = { 'gdscript' },
        root_markers = { 'project.godot', '.git' },
      })
      vim.lsp.enable('gdscript')
    end,
  }
}
