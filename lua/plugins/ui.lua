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
      -- vim.api.nvim_set_hl(0, "LineNr", { bold = false })
      -- vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff875f", bold = true })
    end,
  }, -- lazy
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "nvim-lualine/lualine.nvim", dependencies = { "kyazdani42/nvim-web-devicons" }
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional for file icons
    config = function()

      vim.cmd [[
        highlight NvimTreeFolderArrowClosed guifg=#719cd6
        highlight NvimTreeFolderArrowOpen guifg=#719cd6
      ]]

      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 35,
          side = "left",
          preserve_window_proportions = true,
          signcolumn = "yes",
        },
        renderer = {
        --   group_empty = true,
        --   highlight_git = true,
        --   highlight_opened_files = "all",
          indent_markers = {
            enable = true,
          },
          icons = {
            glyphs = {
              folder = {
                arrow_closed = "⯈", -- e.g., thin arrow
                arrow_open = "⯆",
              },
            },
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,

            },
          },
        },
        -- filters = {
        --   dotfiles = false,
        -- },
        -- git = {
        --   enable = true,
        --   ignore = false,
        --   timeout = 500,
        -- },
      })
    end
  }
}

