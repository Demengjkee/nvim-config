--lspconfig.lua
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      local lspconfig = require("lspconfig")
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Lua LSP
      lspconfig.lua_ls.setup {
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
      }

      -- C/C++ LSP (clangd)
      lspconfig.clangd.setup { capabilities = capabilities }

      -- Go LSP (gopls)
      lspconfig.gopls.setup { capabilities = capabilities }

      -- Java LSP (jdtls)
      lspconfig.jdtls.setup { capabilities = capabilities }
      -- Python LSP (pyright)
      lspconfig.pyright.setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          local opts = { buf = bufnr }
          vim.api.nvim_set_option_value('expandtab', true, opts) -- Use spaces instead of tabs
          vim.api.nvim_set_option_value('shiftwidth', 2, opts)   -- Number of spaces for indentation
          vim.api.nvim_set_option_value('tabstop', 2, opts)
        end,
      }

      lspconfig.bashls.setup { capabilities = capabilities }
      lspconfig.jsonls.setup { capabilities = capabilities }

      lspconfig.marksman.setup { capabilities = capabilities }
      lspconfig.terraformls.setup {
        filetypes = { "terraform", "terraform-vars", "tf", "tfvars" },
        capabilities = capabilities,
      }

      lspconfig.gh_actions_ls.setup { capabilities = capabilities }
      lspconfig.gitlab_ci_ls.setup { capabilities = capabilities }

      lspconfig.ts_ls.setup {
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
      }

      lspconfig.dockerls.setup { capabilities = capabilities }

      lspconfig.texlab.setup {
        capabilities = capabilities,
        settings = {
          texlab = {
            latex = {
              enabled = true,
            }
          }
        }
      }
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
