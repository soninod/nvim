vim.g.mapleader = " " -- Space as leader key
local keymap = vim.api.nvim_set_keymap

keymap("n", "<Leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
keymap("n", "<Leader>fd", ":Telescope find_files find_command=fd,--type,d<CR>", { noremap = true, silent = true })
keymap("n", "<Leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
keymap("n", "<Leader>fw", ":Telescope grep_string<CR>", { noremap = true, silent = true })
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
