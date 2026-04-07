return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'master',
        lazy = false,
        build = ':TSUpdate',
        config = function()
          require("nvim-treesitter.configs").setup({
            ensure_installed = { "gdscript", "godot_resource", "gdshader", "lua", "typescript" },
            auto_install = false,
            highlight = {
                enable = true,
            },
            indent = { enable = true},
          })
        end,
    },
}
