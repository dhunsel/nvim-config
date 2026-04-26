return
{
  {
    "neovim/nvim-lspconfig",
    ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    init = function()
      vim.lsp.config('tailwindcss', {
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      })
      vim.lsp.enable('tailwindcss')
    end,
  }
}
