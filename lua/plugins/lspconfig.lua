--telescope.lua
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- Lua LSP
      lspconfig.lua_ls.setup {
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
      lspconfig.clangd.setup {}

      -- Go LSP (gopls)
      lspconfig.gopls.setup {}

      -- Java LSP (jdtls)
      lspconfig.jdtls.setup {}
      -- Python LSP (pyright)
      lspconfig.pyright.setup {
        -- settings = {
        --   python = {
        --     pythonPath = vim.fn.exepath('python3'),
        --   }
        -- },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = true
          local opts = { buf = bufnr }
          vim.api.nvim_set_option_value('expandtab', true, opts) -- Use spaces instead of tabs
          vim.api.nvim_set_option_value('shiftwidth', 2, opts)   -- Number of spaces for indentation
          vim.api.nvim_set_option_value('tabstop', 2, opts)
        end,
      }

      -- lspconfig.pylsp.setup {}

      -- Bash LSP (bash-language-server)
      lspconfig.bashls.setup {}

      -- json and yaml
      lspconfig.jsonls.setup {}
      -- lspconfig.yamlls.setup {}

      lspconfig.marksman.setup {
        filetypes = { "makefile", "mkd" },
      }
      local tfcapabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
      lspconfig.terraformls.setup {
        filetypes = { "terraform", "terraform-vars", "tf", "tfvars" },
        capabilities = tfcapabilities,
      }

      lspconfig.gh_actions_ls.setup {}
      lspconfig.gitlab_ci_ls.setup {}

      lspconfig.gitlab_ci_ls.setup {}

      lspconfig.ts_ls.setup {
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

      lspconfig.dockerls.setup {}

      local latexcap = require('cmp_nvim_lsp').default_capabilities()
      lspconfig.texlab.setup {
        capabilities = latexcap,
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
    end,
  },
  { "folke/lsp-trouble.nvim" },
  --[[
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Formatters
          null_ls.builtins.formatting.stylua, -- Lua formatter
          null_ls.builtins.formatting.shfmt, -- Bash formatter
          null_ls.builtins.formatting.black, -- Python formatter
          null_ls.builtins.formatting.prettier, -- Javascript,Typescript,JSON,YAML etc.
          null_ls.builtins.formatting.clang_format, -- C/C++ formatter

          -- Diagnostics (Linters)
          null_ls.builtins.diagnostics.flake8, -- Python linter
          null_ls.builtins.diagnostics.shellcheck, -- Bash linter
          null_ls.builtins.diagnostics.eslint_d, -- Javascript,Typescript linter
          null_ls.builtins.diagnostics.cppcheck, -- C/C++ linter

          -- Completion
          null_ls.builtins.completion.spell, -- Spell check completion.

          -- Code Actions
          null_ls.builtins.code_actions.gitsigns, -- Gitsigns code actions.
        },
      })
    end,
    dependencies = {
        {"nvim-lua/plenary.nvim"}
    }
  },
--]]
}
