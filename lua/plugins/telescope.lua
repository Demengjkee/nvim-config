--telescope.lua
return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function ()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            "%.git/",
            "__pycache__/", "%.venv/", "node_modules/", "vendor/",
            "%.terraform/"
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--unrestricted',
        },
      })
    end,
}
