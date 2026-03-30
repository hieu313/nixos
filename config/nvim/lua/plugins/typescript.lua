-- ~/.config/nvim/lua/plugins/typescript.lua

return {
  -- TypeScript language server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          enabled = false, -- Disable tsserver in favor of ts_ls or vtsls
        },
        ts_ls = {
          enabled = false,
        },
        -- Alternative: vtsls (faster TypeScript language server)
        vtsls = {
          enabled = true, -- Set to true if you prefer vtsls over ts_ls
          settings = {
            typescript = {
              preferences = {
                importModuleSpecifier = "relative",
              },
            },
          },
        },
      },
    },
  },

  -- ESLint
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },
      },
      setup = {
        eslint = function()
          require("lazyvim.util").lsp.on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "ts_ls" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },

  -- Formatting with prettier
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
      },
    },
  },

  -- Enhanced TypeScript features
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        expose_as_code_action = "all",
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "typescript",
          "tsx",
          "javascript",
          "jsdoc",
        })
      end
    end,
  },

  -- Additional useful tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        "js-debug-adapter",
      })
    end,
  },
}