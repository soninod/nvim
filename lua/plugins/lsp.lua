-- ~/.config/nvim/init.lua
return {
  -- Mason: LSP / tools manager
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ts_ls", "lua_ls" }, -- Pyright + TypeScript
      })
    end,
  },
  -- LuaSnip snippets collection (optional)
  { "rafamadriz/friendly-snippets" },

    -- Flutter & Dart
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
    },
  },

  -- LSP configuration (v0.11+ аргаар)
  { "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      -- HTML / CSS
      vim.lsp.config("HTML", {})
      vim.lsp.config("CSS", {})


      -- Pyright
      vim.lsp.config("pyright", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      vim.lsp.enable("pyright")

      -- TypeScript
      vim.lsp.config("ts_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
      })
      vim.lsp.enable("ts_ls")

      -- Lua
      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      vim.lsp.enable("lua_ls")

      -- Vue 2
      vim.lsp.config("vls", {
        cmd = { "vls" },
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { "vue" },
        init_options = {
          config = {
            vetur = {
              validation = {
                template = true,
                script = true,
                style = true,
              },
            },
          },
        },
      })
      vim.lsp.enable("vls")

      -- Flutter / Dart
      require("flutter-tools").setup({
        lsp = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      })

    end,
  },
  -- Autocomplete + Snippets
  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
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
