return {
  -- {
  --   "folke/tokyonight.nvim",
  --   config = function()
  --     -- vim.cmd("colorscheme tokyonight-storm")
  --     -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#7aa2f7", bold = true })
  --     -- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e0af68", bold = true })
  --   end,
  --   opts = {
  --     transparent = true,
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --   },
  -- },
  { "prisma/vim-prisma" },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            functions = "bold",
            sidebars = "transparent",
            floats = "transparent",
          },
        },
      })
      vim.cmd("colorscheme terafox")
      -- vim.api.nvim_set_hl(0, "LineNr", { fg = "#7aa2f7", bold = true })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#e0af68", bold = true })
      -- vim.api.nvim_set_hl(0, "CursorLine", { fg = "#e0af68", bold = true })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1f2e30" })
      vim.opt.cursorline = true
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons" }
  },
}

