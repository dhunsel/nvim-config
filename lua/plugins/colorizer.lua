return
{
  {
    "catgoose/nvim-colorizer.lua",
    ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
    opts = {
      filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
      user_commands = true,
      options = {
        parsers = {
          css = true,
          oklch = { enable = true },
          css_var = { enable = true, parsers = { css = true } },
          tailwind = {
            enable = true,
            lsp = true,
            update_names = true,
          },
        },
        display = {
          mode = "background",
        },
      },
    },
  }
}
