vim.g.mapleader = " " -- Space as leader key
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

keymap("n", "<Leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<Leader>fd", ":Telescope find_files find_command=fd,--type,d<CR>", opts)
keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<Leader>fw", ":Telescope grep_string<CR>", opts)
keymap("n", "<Leader>e", ":lua vim.diagnostic.open_float()<CR>", opts)
-- keymap("n", "<leader>i", require("lspimport").import(), opts)
