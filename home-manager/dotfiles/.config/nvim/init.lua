vim.opt.compatible = false -- Disable compatibility to old-time vi
vim.opt.showmatch = true -- Show matching
vim.opt.hlsearch = true -- Highlight search
vim.opt.incsearch = true -- Incremental search
vim.opt.tabstop = 4 -- Number of columns occupied by a tab
vim.opt.softtabstop = 4 -- See multiple spaces as tabstops so <BS> does the right thing
vim.opt.expandtab = true -- Converts tabs to white space
vim.opt.shiftwidth = 4 -- Width for autoindents
vim.opt.autoindent = true -- Indent a new line the same amount as the line just typed
vim.opt.smartindent = true -- Smart indent

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { trail = '@' }

-- Add line numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.encoding = 'UTF-8' -- Set encoding to UTF-8
vim.opt.swapfile = false -- Disable swap file

-- Folding
vim.opt.foldmethod = 'indent'
vim.opt.foldlevelstart = 99

-- hotkeys
vim.api.nvim_set_keymap(
'n', '<leader>c', ':set cc=80<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap(
'n', '<leader>C', ':set cc=0<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap(
'n', '<leader>n', ':noh<CR>', { noremap = true, silent = true })

-- Autocommands
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'javascript',
    command = 'nnoremap <buffer> <C-n> :!node %<CR>',
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'javascript',
    command = 'nnoremap <buffer> <C-l> :!npx eslint %<CR>',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'haskell',
    command = 'nnoremap <buffer> <C-n> :!runhaskell %<CR>',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'haskell',
    command = 'nnoremap <buffer> <C-l> :!hlint %<CR>',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'sh',
    command = 'nnoremap <buffer> <C-l> :!shellcheck %<CR>',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'clojure',
    command = 'nnoremap <buffer> <C-n> :!clojure %<CR>',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'go',
    command = 'nnoremap <buffer> <C-n> :!go run %<CR>',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'go',
    command = 'nnoremap <buffer> <C-l> :!golangci-lint run %<CR>',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'rust',
    command = 'nnoremap <buffer> <C-n> :!cargo run %<CR>',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'rust',
    command = 'nnoremap <buffer> <C-l> :!cargo check<CR>',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    command = 'nnoremap <buffer> <C-n> :!pandoc -s % -o %:r.pdf<CR>',
})


-- Color settings
vim.cmd('colorscheme minimalist')
vim.cmd('highlight Normal ctermbg=none')
vim.cmd('highlight NonText ctermbg=none')
vim.cmd('highlight ColorColumn ctermbg=238')
vim.cmd('highlight ExtraWhitespace ctermbg=red guibg=red')
vim.cmd('match ExtraWhitespace /\\s\\+$/')


-- Co-pilot settings
vim.g.copilot_enabled = false
vim.g.copilot_filetypes = {
    ['*'] = false,
    ['javascript'] = true,
    ['python'] = true,
    ['sql'] = true,
    ['sh'] = true,
    ['haskell'] = true,
    ['gitcommit'] = true,
    ['vim'] = true,
    ['css'] = true,
    ['html'] = true,
    ['c'] = true,
    ['cpp'] = true,
    ['h'] = true,
    ['go'] = true,
}

-- LSP Config
local on_attach = function(_, _)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, {})
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, {})
end

local lspconfig = require('lspconfig')

lspconfig.gopls.setup {on_attach = on_attach}
lspconfig.rust_analyzer.setup {on_attach = on_attach}
lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
    on_attach = on_attach
}

lspconfig.tsserver.setup {
    on_attach = on_attach,
    init_options = {
        preferences = {
            disableSuggestions = true
        }
    }
}

lspconfig.eslint.setup {}
