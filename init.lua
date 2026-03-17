require("config.lazy")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cc = "80,120"
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    focusable = false,
  },
})

-- keys
local tsbuiltin = require('telescope.builtin')
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map('n', '<leader>ff', tsbuiltin.find_files, opts)
map('n', '<leader>fg', tsbuiltin.live_grep, opts)
map('n', '<leader>fb', ":Telescope file_browser path=%:p:h select_buffer=true<CR>", opts)
map('n', '<leader>fh', tsbuiltin.help_tags, opts)

map('n', '<C-t>', ":NvimTreeToggle<CR>", opts)

map('n', '<leader>gd', vim.lsp.buf.definition, opts)
map('n', '<leader>gr', vim.lsp.buf.references, opts)
map('n', '<leader>gi', vim.lsp.buf.implementation, opts)
map('n', '<leader>K', vim.lsp.buf.hover, opts)
map('n', '<leader>rn', vim.lsp.buf.rename, opts)
map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
map('n', '<leader>cf', vim.lsp.buf.format, opts)
map('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, opts)
map('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, opts)
map('n', '<leader>q', vim.diagnostic.open_float, opts)
map('n', '<leader>dl', '<cmd>Trouble diagnostics toggle<cr>', opts)
map('n', '<leader>ls', function() print(vim.inspect(vim.lsp.get_clients())) end, opts)
map('n', '<leader>gl', '<C-o>', opts)
map('n', '<leader>bp', ':bprevious<CR>', opts)
map('n', '<leader>bn', ':bnext<CR>', opts)

map('n', '<leader>tt', ':sp | wincmd j | terminal<CR>i', opts)

map('n', '<leader>tu', vim.cmd.UndotreeToggle, opts)

map('n', '<leader>s ', function() vim.cmd('s/\\s\\+$//e') end, opts)
map('n', '<leader>sa', function() vim.cmd('%s/\\s\\+$//e') end, opts)

map('n', '<leader>?', function() require("which-key").show({ global = false }) end, opts)

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "t", "<Esc><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- color
local term = os.getenv("TERM")
if term == "alacritty" or term == "xterm-ghostty" then
  vim.cmd("colorscheme tokyonight")
elseif not term or string.sub(term, 1, 5) == "xterm" then
  vim.cmd("colorscheme darkblue")
end

-- terraform
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- which-key
local wk = require("which-key")
wk.add({
  { "<C-t>",      desc = "Toggle NvimTree" },
  { "<leader>K",  desc = "Hover Documentation" },
  { "<leader>ca", desc = "Code Action" },
  { "<leader>cf", desc = "Format Code" },
  { "<leader>f",  group = "Telescope" },
  { "<leader>fb", desc = "File Browser" },
  { "<leader>ff", desc = "Find Files" },
  { "<leader>fg", desc = "Live Grep" },
  { "<leader>fh", desc = "Help Tags" },
  { "<leader>g",  group = "LSP Gotos" },
  { "<leader>gd", desc = "Go to Definition" },
  { "<leader>gi", desc = "Go to Implementation" },
  { "<leader>gr", desc = "Find References" },
  { "<leader>gl", desc = "Go to last file" },
  { "<leader>ls", desc = "List LSP Clients" },
  { "<leader>q",  desc = "Open Diagnostic Float" },
  { "<leader>d",  group = "Diagnostics" },
  { "<leader>dl", desc = "Diagnostics List" },
  { "<leader>rn", desc = "Rename" },
  { "[d",         desc = "Previous Diagnostic" },
  { "]d",         desc = "Next Diagnostic" },
  { "<leader>b",  group = "Buffers" },
  { "<leader>bp", desc = "Previous Buffer" },
  { "<leader>bn", desc = "Next Buffer" },
  { "<leader>tt", desc = "Open a terminal" },
  { "<leader>tu", desc = "Open an Undo Tree" },
  { "<leader>s",  group = "Strip Whitespace" },
  { "<leader>s ", desc = "Strip Trailing (line)" },
  { "<leader>sa", desc = "Strip Trailing (file)" },
  { "<leader>?",  desc = "Buffer Local Keymaps" },
})
