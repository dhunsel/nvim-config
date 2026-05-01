return 
{
  {
    "neovim/nvim-lspconfig",
    ft = {  "javascript", "javascriptreact", "typescript", "typescriptreact" },
    config = function()
      vim.lsp.config('eslint', {
        cmd = { 'node', vim.fn.expand('~/.local/share/nvim/eslint-lsp/eslintServer.js'), '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        root_markers = { 'eslint.config.js', 'eslint.config.mjs', '.eslintrc.js', '.eslintrc.json', '.eslintrc', 'package.json' },
      })
      vim.lsp.enable('eslint')
    end,
  }
}
