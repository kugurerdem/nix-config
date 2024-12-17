vim.opt.compatible = false -- Disable compatibility to old-time vi
vim.opt.showmatch = true -- Show matching
vim.opt.hlsearch = true -- Highlight search
vim.opt.incsearch = true -- Incremental search

-- Default tab & indendation settings
vim.opt.expandtab = true -- Converts tabs to white space
vim.opt.tabstop = 4 -- Number of columns occupied by a tab
vim.opt.softtabstop = 4 -- See multiple spaces as tabstops so <BS> does the right thing
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

-- Some plugins rely on these values, if not set, both are \ by default
vim.g.mapleader = '\\'
vim.g.maplocalleader = ','

-- hotkeys
vim.api.nvim_set_keymap(
'n', '<leader>c', ':set cc=80<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap(
'n', '<leader>C', ':set cc=0<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap(
'n', '<leader>n', ':noh<CR>', { noremap = true, silent = true })

local function soft_wrap()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.o.columns = 80
    print("Wrap and linebreak on; columns set to 80")
end

vim.api.nvim_create_user_command("SoftWrap", soft_wrap, {})

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    -- Indentation settings
    vim.opt_local.expandtab = false
    vim.opt.list = false

    -- Key mappings
    vim.keymap.set("n", "<C-n>", ":!go run %<CR>", { buffer = true, silent = true })
    vim.keymap.set("n", "<C-l>", ":!golangci-lint run %<CR>", { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'rust',
    callback = function()
        vim.keymap.set(
            'n', '<C-n>', ':!cargo run<CR>',
            { buffer = true, silent = true }
        )
        vim.keymap.set(
            'n', '<C-l>', ':!cargo check<CR>',
            { buffer = true, silent = true }
        )
    end,
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
vim.g.copilot_enabled = true
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
    ['lua'] = true,
    ['nix'] = true,
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

lspconfig.ts_ls.setup {
    on_attach = on_attach,
    init_options = {
        preferences = {
            disableSuggestions = true
        }
    }
}

lspconfig.eslint.setup {}

lspconfig.clojure_lsp.setup {}

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', telescope_builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>ss', telescope_builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', telescope_builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', telescope_builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader><leader>', telescope_builtin.buffers, { desc = '[ ] Find existing buffers' })
