vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+$//e", -- Remove trailing whitespace on save
})

-- Reload command
vim.api.nvim_create_user_command('ReloadTelescope', function()
    package.loaded['telescope'] = nil
    package.loaded['nvim-web-devicons'] = nil

    -- Reload modules
    require'nvim-web-devicons'.setup { default = true }
    require('telescope').setup{
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
      },
      pickers = { find_files = { hidden = true } }
    }

    print("Telescope reloaded!")
end, {})

