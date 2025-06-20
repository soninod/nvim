local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins.ui" },         -- UI Plugins
  { import = "plugins.lsp" },        -- LSP & Autocompletion
  { import = "plugins.treesitter" }, -- Syntax highlighting
  { import = "plugins.git" },        -- Git Plugins
  { import = "plugins.tools" },      -- Other Tools (Telescope, Debugging, etc.)
})

