return {
  { "tpope/vim-fugitive" }, -- Git commands in Vim
  { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end }, -- Git status in sign column
}

