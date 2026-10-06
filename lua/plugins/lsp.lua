-- ~/.config/nvim/init.lua
return {
  -- Mason: LSP / tools manager
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "vtsls", "vue_ls", "lua_ls", "gopls", "prismals" },
        -- vue_ls attachment is version-gated (Vue 2 vs 3) by our own FileType
        -- autocmd below; mason-lspconfig's automatic_enable would otherwise
        -- also vim.lsp.enable("vue_ls") unconditionally and race it.
        automatic_enable = { exclude = { "vue_ls" } },
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

      -- Golang
      vim.lsp.config("gopls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      vim.lsp.enable("gopls")

      -- Prisma
      vim.lsp.config("prismals", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      vim.lsp.enable("prismals")

      -- HTML / CSS
      vim.lsp.config("HTML", {})
      vim.lsp.config("CSS", {})


      -- Pyright
      vim.lsp.config("pyright", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      vim.lsp.enable("pyright")

      -- Lua
      vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
      vim.lsp.enable("lua_ls")

      -- TypeScript / JavaScript (also powers Vue 3 <script> intelligence, see below)
      local mason_vue_language_server_path = vim.fn.stdpath("data")
        .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

      local vue_typescript_plugin = {
        name = "@vue/typescript-plugin",
        location = mason_vue_language_server_path,
        languages = { "vue" },
        configNamespace = "typescript",
      }

      vim.lsp.config("vtsls", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = { vue_typescript_plugin },
            },
          },
        },
      })
      vim.lsp.enable("vtsls") -- handles plain .js/.ts everywhere, in both Vue 2 and Vue 3 projects

      -- Vue 3 (hybrid mode: template/style here, <script> delegated to vtsls above)
      vim.lsp.config("vue_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Vue 2 (standalone legacy server, pinned to the last version with native Vue 2 support;
      -- @vue/language-server >= 2.0 dropped Vue 2 entirely, so this can't share the modern binary)
      local npm_global_root = vim.trim(vim.fn.system("npm root -g"))
      vim.lsp.config("vue_ls_v2", {
        cmd = { "node", npm_global_root .. "/@vue/language-server/bin/vue-language-server.js", "--stdio" },
        filetypes = { "vue" },
        on_attach = on_attach,
        capabilities = capabilities,
        init_options = {
          typescript = {
            tsdk = npm_global_root .. "/typescript/lib",
          },
        },
      })

      -- Detect the Vue major version installed in a buffer's project (via node_modules/vue),
      -- so the right server (vue_ls vs vue_ls_v2, plus vtsls's <script> delegation) attaches per project.
      local function get_vue_major(bufnr)
        local root = vim.fs.root(bufnr, "package.json")
        if not root then
          return nil
        end
        local ok, lines = pcall(vim.fn.readfile, root .. "/node_modules/vue/package.json")
        if not ok or not lines or #lines == 0 then
          return nil
        end
        local decode_ok, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
        if not decode_ok or type(decoded) ~= "table" or not decoded.version then
          return nil
        end
        return tonumber(decoded.version:match("^(%d+)"))
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "vue",
        group = vim.api.nvim_create_augroup("vue-multi-version-lsp", { clear = true }),
        callback = function(args)
          -- FileType can fire more than once for the same buffer (e.g. on initial
          -- load); vim.lsp.start() resolves root_dir asynchronously, so checking
          -- vim.lsp.get_clients() here would race a second firing. A buffer-local
          -- flag, set synchronously, can't race.
          if vim.b[args.buf].vue_lsp_attached then
            return
          end
          vim.b[args.buf].vue_lsp_attached = true

          if get_vue_major(args.buf) == 2 then
            local root = vim.fs.root(args.buf, "package.json") or vim.fn.getcwd()
            vim.lsp.start(vim.tbl_deep_extend("force", vim.lsp.config.vue_ls_v2, { root_dir = root }), { bufnr = args.buf })
          else
            -- default to Vue 3 tooling when undetectable (e.g. node_modules not installed yet)
            vim.lsp.start(vim.lsp.config.vtsls, { bufnr = args.buf })
            vim.lsp.start(vim.lsp.config.vue_ls, { bufnr = args.buf })
          end
        end,
      })

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
