return {
  { "williamboman/mason.nvim", config = true }, -- LSP installer
  { "pmizio/typescript-tools.nvim", config = true }, -- LSP installer
  { "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.ts_ls.setup{
        on_attach = function(client, bufnr)

          local opts = { noremap=true, silent=true }
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

          buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

        end,
      }
    end,
  }, -- LSP configurations

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP completion
      "L3MON4D3/LuaSnip", -- Snippets
      "saadparwaiz1/cmp_luasnip", -- Connect cmp + snippets
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      })
    end,
  },
}

