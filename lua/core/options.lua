vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true

vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.g.javascript_indent_switch_case = 1
vim.g.javascript_indent_block = 1
vim.g.netrw_liststyle = 0
vim.g.netrw_keepdir = 0

-- Fold text: "<first line> +-- N lines"
function _G.MyFoldText()
  local nl = vim.v.foldend - vim.v.foldstart + 1
  return vim.fn.getline(vim.v.foldstart) .. " +-- " .. nl .. " lines"
end
vim.opt.foldtext = "v:lua.MyFoldText()"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99 -- open all folds when a file is opened
