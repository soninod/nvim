return {
  {
    "nvim-telescope/telescope.nvim", tag = '0.1.8',
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            file_ignore_patterns = {
              "__pycache__/",                 -- __pycache__ хавтас бүхэлд нь
              "__pycache__",                  -- аюулгүй давхар
              "__pycache__/.*%.pyc$",         -- __pycache__ доторх *.pyc файлуудыг төгс хасна
              "%.pyc$",
              ".next/",
              "node_modules/",
              "dist/",
            },
            hidden = false, -- hidden файлуудыг харах
            no_ignore = false
          }
        }
      })
    end,
  },
}

