return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "python",
          "javascript",
          "typescript",
          "tsx",        -- 🔥 React TSX
          "dart",
        },
        highlight = { enable = true },
        indent = {
          enable = true,
          disable = { "python" }, -- optional
        },
      })
    end,
  },
}

