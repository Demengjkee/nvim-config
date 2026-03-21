--lspconfig.lua
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Lua LSP
      vim.lsp.config("lua_ls", {
        cmd = { 'lua-language-server' },
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {
                'vim',
                'require'
              },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- C/C++ LSP (clangd)
      vim.lsp.config("clangd", { capabilities = capabilities })
      vim.lsp.enable("clangd")

      -- Go LSP (gopls)
      vim.lsp.config("gopls", { capabilities = capabilities })
      vim.lsp.enable("gopls")

      -- Java LSP (jdtls)
      vim.lsp.config("jdtls", { capabilities = capabilities })
      vim.lsp.enable("jdtls")

      -- Python LSP (pyright)
      vim.lsp.config("pyright", {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          local opts = { buf = bufnr }
          vim.api.nvim_set_option_value('expandtab', true, opts) -- Use spaces instead of tabs
          vim.api.nvim_set_option_value('shiftwidth', 2, opts)   -- Number of spaces for indentation
          vim.api.nvim_set_option_value('tabstop', 2, opts)
        end,
      })
      vim.lsp.enable("pyright")

      vim.lsp.config("bashls", { capabilities = capabilities })
      vim.lsp.enable("bashls")

      vim.lsp.config("jsonls", { capabilities = capabilities })
      vim.lsp.enable("jsonls")

      vim.lsp.config("marksman", { capabilities = capabilities })
      vim.lsp.enable("marksman")

      vim.lsp.config("terraformls", {
        filetypes = { "terraform", "terraform-vars", "tf", "tfvars" },
        capabilities = capabilities,
      })
      vim.lsp.enable("terraformls")

      vim.lsp.config("gh_actions_ls", { capabilities = capabilities })
      vim.lsp.enable("gh_actions_ls")
      vim.lsp.config("gitlab_ci_ls", { capabilities = capabilities })
      vim.lsp.enable("gitlab_ci_ls")

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
              languages = { "javascript", "typescript", "vue" },
            },
          },
        },
        filetypes = {
          "javascript",
          "typescript",
          "vue",
        },
      })
      vim.lsp.enable("ts_ls")

      vim.lsp.config("dockerls", { capabilities = capabilities })
      vim.lsp.enable("dockerls")

      vim.lsp.config("texlab", {
        capabilities = capabilities,
        settings = {
          texlab = {
            latex = {
              enabled = true,
            }
          }
        }
      })
      vim.lsp.enable("texlab")
    end,
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    }
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "L3MON4D3/LuaSnip" },
      { "hrsh7th/cmp-cmdline" },
      { "saadparwaiz1/cmp_luasnip" },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end,
  },
  {
    "folke/trouble.nvim",
    opts = {},
  },
}
