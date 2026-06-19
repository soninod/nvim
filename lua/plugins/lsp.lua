return {
  { "williamboman/mason.nvim", config = true }, -- LSP installer
  { "pmizio/typescript-tools.nvim", config = true }, -- LSP installer
  -- LSP configurations
  { "neovim/nvim-lspconfig",
    config = function()
      -- capabilities (nvim-cmp эсвэл бусад plugin-тэй хамт)
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- on_attach функцээ нэг удаа тодорхойлно
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true }
        local function map(mode, lhs, rhs)
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end

        map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
      end

      -- сервер бүрт нийтлэг тохиргоо
      local servers = { "ts_ls", "pyright" }

      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end

    end,
  },

  -- flutter lsp config
  {
   'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function ()
      local flutter_tools = require("flutter-tools")

      local home = os.getenv("HOME")

      flutter_tools.setup{
        ui = {
          -- the border type to use for all floating windows, the same options/formats
          -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
          border = "rounded",
          -- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
          -- please note that this option is eventually going to be deprecated and users will need to
          -- depend on plugins like `nvim-notify` instead.
          notification_style = 'native'
        },
        decorations = {
          statusline = {
            -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
            -- this will show the current version of the flutter app from the pubspec.yaml file
            app_version = false,
            -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
            -- this will show the currently running device if an application was started with a specific
            -- device
            device = false,
            -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
            -- this will show the currently selected project configuration
            project_config = false,
          }
        },
        debugger = {
          enabled = false,
          exception_breakpoints = {},
          evaluate_to_string_in_debug_views = true,
        },

        flutter_path = home .. "/development/flutter/bin/flutter",
        flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
        root_patterns = { ".git", "pubspec.yaml" }, -- patterns to find the root of your flutter project
        fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
        default_run_args= nil, -- Default options for run command (i.e `{ flutter = "--no-version-check" }`). Configured separately for `dart run` and `flutter run`.
        widget_guides = {
          enabled = false,
        },

        lsp = {
          on_attach = function(client, bufnr)

            local opts = { noremap=true, silent=true }
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

            buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

          end
        }
      }
    end

  },
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

