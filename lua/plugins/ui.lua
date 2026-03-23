return {
  {
    "folke/tokyonight.nvim",
    config = function()
      -- vim.cmd("colorscheme tokyonight-storm")
      -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#7aa2f7", bold = true })
      -- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e0af68", bold = true })
    end,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme terafox")
    end,
  }, -- lazy
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons" }
  },
}

