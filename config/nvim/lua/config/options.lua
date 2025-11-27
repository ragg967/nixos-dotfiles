-- vim options
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true

-- System clipboard
vim.opt.clipboard = "unnamedplus"

-- Set default theme
vim.cmd('colorscheme kanagawabones')

-- Theme changing
local themes = {'kanagawabones', 'forestbones', 'rosebones', 'zenbones'}
local current = 1

vim.keymap.set('n', '<leader>tt', function()
  current = current % #themes + 1
  vim.cmd('colorscheme ' .. themes[current])
  print('Theme: ' .. themes[current])
end)
