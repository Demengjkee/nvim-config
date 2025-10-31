return {
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function ()
      require("nvim-autopairs").setup {}
    end,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
}
