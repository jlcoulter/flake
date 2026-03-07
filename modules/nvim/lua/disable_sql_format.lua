-- ~/.config/nvim/lua/disable_sql_format.lua
vim.api.nvim_create_autocmd("FileType", {
    pattern = "sql",
    callback = function()
        -- completely stop format on save
        vim.b.disableFormatSave = true

        -- stop any other auto-format/autocmd
        vim.opt_local.formatoptions = ""
        vim.opt_local.textwidth = 0
        vim.opt_local.expandtab = false
    end,
})
