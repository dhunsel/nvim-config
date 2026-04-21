return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require("nvim-treesitter").install({
                "gdscript", "godot_resource", "gdshader",
                "lua", "typescript", "tsx", "javascript", "html", "css", "c_sharp",
            })

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },
}
