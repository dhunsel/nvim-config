return {
    {
        "seblj/roslyn.nvim",
        ft = { "cs", "razor", "cshtml" },
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        opts = {
            filewatching = "auto",
            lock_target = false,
            silent = false,
        },
    },
}
