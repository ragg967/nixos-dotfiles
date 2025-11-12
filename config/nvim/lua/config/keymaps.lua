local keymap = vim.keymap.set

-- Mini pick
keymap('n', '<leader>ff', '<cmd>Pick files<cr>', { desc = 'Find files' })
keymap('n', '<leader>fg', '<cmd>Pick grep_live<cr>', { desc = 'Live grep' })
keymap('n', '<leader>fb', '<cmd>Pick buffers<cr>', { desc = 'Find buffers' })
keymap('n', '<leader>fh', '<cmd>Pick help<cr>', { desc = 'Help tags' })
keymap('n', '<leader>fr', '<cmd>Pick resume<cr>', { desc = 'Resume last picker' })
keymap('n', '<leader>/', '<cmd>Pick buf_lines<cr>', { desc = 'Search buffer lines' })

-- Mini.files
keymap('n', '<leader>e', '<cmd>lua MiniFiles.open()<cr>', { desc = 'Open file explorer' })
keymap('n', '-', '<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>', { desc = 'Open parent directory' })

-- Lsp
keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
keymap('n', 'gr', vim.lsp.buf.references, { desc = 'References' })
keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

-- Linter
keymap('n', '<leader>gf', vim.lsp.buf.format, {})
