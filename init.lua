-- packer
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'voldikss/vim-floaterm' --floating terminal

    --lsp related stuff and some other things--
    use { 'neoclide/coc.nvim', branch = 'release' }
    use 'OmniSharp/omnisharp-vim'

    --syntax highlight
    use 'octol/vim-cpp-enhanced-highlight'
    use 'jlcrochet/vim-cs'

    --statusline and buffer line--
    use
    {
        'nvim-lualine/lualine.nvim',
    }

    use 'nvim-tree/nvim-tree.lua'  --file tree

    --use 'tribela/vim-transparent'  --transparent bg(i want to use neovim without it fow now)
    use 'ThePrimeagen/vim-be-good' --funny game bruh
    use 'svermeulen/vim-cutlass'   --makes d delete, not cut

    use
    {
        "ej-shafran/compile-mode.nvim",
        tag = "v5.*",
        branch = "nightly",
        requires = {
            "nvim-lua/plenary.nvim",
            {
                "m00qek/baleia.nvim",
                tag = "v1.3.0",
            },
        },
        config = function()
            ---@type CompileModeOpts
            vim.g.compile_mode = {
                buffer_name="compilation",
                -- to add ANSI escape code support, add:
                baleia_setup = true,
            }
        end,
    }

  --  use --debugger
  --  { "rcarriga/nvim-dap-ui",
  --      requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  --      config = function()
  --          local dap = require("dap")
  --          local dapui = require("dapui")
  --          dapui.setup()
  --          dap.listeners.after.event_initialized["dapui_config"] = function()
  --              dapui.open()
  --          end
  --          dap.listeners.before.event_terminated["dapui_config"] = function()
  --              dapui.close()
  --          end
  --          dap.listeners.before.event_exited["dapui_config"] = function()
  --              dapui.close()
  --          end
  --      end
  --  }
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    use "rktjmp/lush.nvim"
    use 'sphamba/smear-cursor.nvim' -- smooth cursor
    use 'karb94/neoscroll.nvim'     -- smooth scroll
end)
-- gui settings

if vim.g.neovide then
    vim.o.guifont = "Iosevka Fixed SS15:h20"
end

-- vim-plug (i use it only for themes lmao)
local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug 'estheruary/nvim-colorscheme-lavender' -- use with ai bg
Plug 'fenetikm/falcon'                      -- use with nullscapes bg
Plug 'wincent/base16-nvim'
Plug 'ntk148v/komau.vim'

vim.call('plug#end')

--[[  colemak layout support  ]] --
-- based on https://github.com/linduxed/colemak.nvim
local colemak_mappings = {
    -- Up/down/left/right
    { modes = { "n", "o", "x" }, lhs = "n",          rhs = "h",      desc = "Left (h)" },
    { modes = { "n", "o", "x" }, lhs = "u",          rhs = "k",      desc = "Up (k)" },
    { modes = { "n", "o", "x" }, lhs = "e",          rhs = "j",      desc = "Down (j)" },
    { modes = { "n", "o", "x" }, lhs = "i",          rhs = "l",      desc = "Right (l)" },
    { modes = { "n", "o", "x" }, lhs = "N",          rhs = "H",      desc = "Left (h)" },
    { modes = { "n", "o", "x" }, lhs = "U",          rhs = "K",      desc = "Up (k)" },
    { modes = { "n", "o", "x" }, lhs = "E",          rhs = "J",      desc = "Down (j)" },
    { modes = { "n", "o", "x" }, lhs = "I",          rhs = "L",      desc = "Right (l)" },

    -- Jumplist navigation
    { modes = { "n" },           lhs = "<C-u>",      rhs = "<C-i>",  desc = "Jumplist forward" },
    { modes = { "n" },           lhs = "<C-e>",      rhs = "<C-o>",  desc = "Jumplist forward" },

    -- Word left/right
    { modes = { "n", "x" },      lhs = "a",          rhs = "b",      desc = "Word back" },
    { modes = { "n", "x" },      lhs = "t",          rhs = "w",      desc = "Word forward" },
    { modes = { "n", "v" },      lhs = "A",          rhs = "B",      desc = "WORD back" },
    { modes = { "n", "v" },      lhs = "T",          rhs = "W",      desc = "WORD forward" },

    -- Brace movement
    { modes = { "n", "o", "x" }, lhs = "x",          rhs = "%" },


    -- End of word left/right
    { modes = { "n", "o", "x" }, lhs = "N",          rhs = "ge",     desc = "End of word back" },
    { modes = { "n", "o", "x" }, lhs = "<M-n>",      rhs = "gE",     desc = "End of WORD back" },
    { modes = { "n", "o", "x" }, lhs = "I",          rhs = "e",      desc = "End of word forward" },
    { modes = { "n", "o", "x" }, lhs = "<M-i>",      rhs = "E",      desc = "End of WORD forward" },

    -- Text objects
    -- Move visual replace from 'r' to 'R'
    { modes = { "o", "v" },      lhs = "R",          rhs = "r",      desc = "Replace" },

    -- Copy/paste/delete/cut
    { modes = { "n", "o", "x" }, lhs = "y",          rhs = "y" },
    { modes = { "n", "x" },      lhs = "p",          rhs = "p" },
    { modes = { "n", "o", "x" }, lhs = "c",          rhs = "c" },
    { modes = { "n", "o", "x" }, lhs = "c",          rhs = "c" },
    { modes = { "n", "o", "x" }, lhs = "cc",         rhs = "cc" },  -- cut fix, cutlass deletes with c, which is not comfotable for me

    -- fixes
    { modes = { "n", "o", "x" }, lhs = "ci",         rhs = "ci" },
    { modes = { "n", "o", "x" }, lhs = "yi",         rhs = "yi" },
    { modes = { "n", "o", "x" }, lhs = "vi",         rhs = "vi" },
    { modes = { "n", "o", "x" }, lhs = "gd",         rhs = "gd" },
    { modes = { "n", "o", "x" }, lhs = "di",         rhs = "\"_di" },
    { modes = { "n", "o", "x" }, lhs = "<C-w>n",     rhs = "<C-w>h", },
    { modes = { "n", "o", "x" }, lhs = "<C-w>u",     rhs = "<C-w>k", },
    { modes = { "n", "o", "x" }, lhs = "<C-w>e",     rhs = "<C-w>j", },
    { modes = { "n", "o", "x" }, lhs = "<C-w>i",     rhs = "<C-w>l", },
    { modes = { "n", "o", "x" }, lhs = "<C-w>N",     rhs = "<C-w>H", },
    { modes = { "n", "o", "x" }, lhs = "<C-w>U",     rhs = "<C-w>K", },
    { modes = { "n", "o", "x" }, lhs = "<C-w>E",     rhs = "<C-w>J", },
    { modes = { "n", "o", "x" }, lhs = "<C-w>I",     rhs = "<C-w>L", },


    -- Undo/redo
    { modes = { "n" },           lhs = "l",          rhs = "u" },
    { modes = { "n" },           lhs = "gz",         rhs = "U" },
    { modes = { "n" },           lhs = "L",          rhs = "<C-r>" },

    -- insert/append (T)
    { modes = { "n" },           lhs = "j",          rhs = "i" },
    { modes = { "n" },           lhs = "J",          rhs = "I" },
    { modes = { "n" },           lhs = "b",          rhs = "a" },
    { modes = { "n" },           lhs = "B",          rhs = "A" },

    -- Insert in Visual mode
    { modes = { "v" },           lhs = "J",          rhs = "I" },

    -- Search
    { modes = { "n", "o", "x" }, lhs = "k",          rhs = "n" },
    { modes = { "n", "o", "x" }, lhs = "K",          rhs = "N" },

    -- 'til
    -- Breaks diffput
    { modes = { "n", "o", "x" }, lhs = "_",          rhs = "t" },
    { modes = { "n", "o", "x" }, lhs = "_",          rhs = "T" },


    -- Folds
    { modes = { "n", "x" },      lhs = "z",          rhs = "z" },
    { modes = { "n", "x" },      lhs = "z",          rhs = "zb",     desc = "Scroll line and cursor to bottom" },
    { modes = { "n", "x" },      lhs = "zu",         rhs = "zk",     desc = "Move up to fold" },
    { modes = { "n", "x" },      lhs = "ze",         rhs = "zj",     desc = "Move down to fold" },

    -- Fix diffput (t for 'transfer')
    { modes = { "n" },           lhs = "dt",         rhs = "dp",     desc = "diffput (t for 'transfer')" },


    -- Misc overridden keys must be prefixed with g
    { modes = { "n", "x" },      lhs = "gX",         rhs = "X" },
    { modes = { "n", "x" },      lhs = "gU",         rhs = "U" },
    { modes = { "n", "x" },      lhs = "gQ",         rhs = "Q" },
    { modes = { "n", "x" },      lhs = "gK",         rhs = "K" },
    -- extra alias
    { modes = { "n" },           lhs = "gh",         rhs = "K" },
    { modes = { "x" },           lhs = "gh",         rhs = "K" },

    -- Window navigation
    { modes = { "n" },           lhs = "<C-w>n",     rhs = "<C-w>h" },
    { modes = { "n" },           lhs = "<C-w>u",     rhs = "<C-w>k" },
    { modes = { "n" },           lhs = "<C-w>e",     rhs = "<C-w>j" },
    { modes = { "n" },           lhs = "<C-w>i",     rhs = "<C-w>l" },
    { modes = { "n" },           lhs = "<C-w>N",     rhs = "<C-w>H" },
    { modes = { "n" },           lhs = "<C-w>U",     rhs = "<C-w>K" },
    { modes = { "n" },           lhs = "<C-w>E",     rhs = "<C-w>J" },
    { modes = { "n" },           lhs = "<C-w>I",     rhs = "<C-w>L" },
    -- Disable spawning empty buffer
    { modes = { "n" },           lhs = "<C-w><C-n>", rhs = "<nop>" },
}

function colemak_apply()
    for _, mapping in pairs(colemak_mappings) do
        vim.keymap.set(
            mapping.modes,
            mapping.lhs,
            mapping.rhs,
            { desc = mapping.desc }
        )
    end
end

function colemak_unapply()
    for _, mapping in pairs(colemak_mappings) do
        vim.keymap.del(mapping.modes, mapping.lhs)
    end
end

function colemak_setup(_)
    colemak_apply()

    vim.api.nvim_create_user_command(
        "ColemakEnable",
        colemak_apply,
        { desc = "Applies Colemak mappings" }
    )
    vim.api.nvim_create_user_command(
        "ColemakDisable",
        colemak_unapply,
        { desc = "Removes Colemak mappings" }
    )
end

colemak_setup()
--[[ Plugins Setup ]]

require("nvim-tree").setup()

require("smear_cursor").toggle()

neoscroll = require('neoscroll')

neoscroll.setup({
    mappings = { -- Keys to be mapped to their corresponding default scrolling animation
        '<C-u>', '<C-d>',
        '<C-b>', '<C-f>',
        '<C-y>', '<C-e>',
        'zt', 'zz', 'zb'
    },
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = false,            -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    duration_multiplier = 1.0,   -- Global duration multiplier
    easing = 'linear',           -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
    ignored_events = {           -- Events ignored while scrolling
        'WinScrolled', 'CursorMoved'
    },
})
local keymap = {
    ["<M-u>"] = function() neoscroll.scroll(-1, { move_cursor = false, duration = 30, easing = "cubic" }) end,
    ["<M-e>"] = function() neoscroll.scroll(1, { move_cursor = false, duration = 30, easing = "cubic" }) end,
    ["<C-u>"] = function() neoscroll.scroll(-10, { move_cursor = true, duration = 30, easing = "cubic" }) end,
    ["<C-e>"] = function() neoscroll.scroll(10, { move_cursor = true, duration = 30, easing = "cubic" }) end,

}
local modes = { 'n', 'v', 'x' }
for key, func in pairs(keymap) do
    vim.keymap.set(modes, key, func)
end
-- dap
--local dap = require('dap')
--dap.adapters.coreclr = {
--    type = 'executable',
--    command = 'C:\\netcoredbg',
--    args = { '--interpreter=vscode' }
--}
--
--dap.configurations.cs = {
--    {
--        type = "coreclr",
--        name = "launch - netcoredbg",
--        request = "launch",
--        program = function()
--            return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
--        end,
--    },
--}
--require("dapui").setup()
--[[ Editor ]]
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("syntax on")
vim.cmd("filetype on")
vim.cmd("filetype indent on")
vim.cmd("set t_Co=256")
-- line numbers
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
-- clipboard
vim.opt.clipboard      = 'unnamedplus'

--window auto extend
vim.opt.wrap           = true

-- encoding
vim.opt.encoding       = 'utf-8'

-- status bar
vim.opt.laststatus     = 2
-- dont show -- INSERT -- -- VISUAL -- and etc
vim.cmd("set noshowmode")

-- english lang
vim.api.nvim_exec('language en_US', true)

-- gnu assembly syntax highlighting
vim.opt.ft          = 'gas'

-- tab options
vim.opt.expandtab   = true
vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.autoindent  = true
vim.opt.smarttab    = true
vim.opt.softtabstop = 2
vim.opt.cindent     = true

-- gui settings
vim.opt.guifont     = 'JetBrainsMonoNL Nerd Font Mono:h14' -- JetBrainsMonoNL_NFM_Medium:h12:W500:cANSI:qDRAFT
--vim.opt.guioptions  = 'T'

-- autocommands

-- no more needed --
--vim.api.nvim_create_autocmd("VimEnter", {
--    command = [[silent execute "!echo " . v:servername . " > servername.txt"]],
--})

---------   theme  ---------
vim.o.background = "dark"

-- lualine
local rem_colors = {
    black     = '#000000',
    white     = '#eeeeee',
    darkwhite = '#d4d4d4',
    red       = '#ffa0a0',
    green     = '#88cf88',
    blue      = '#78a9ff',
    magenta   = '#feacd0',
    cyan      = '#a0bfdf',
    gray      = '#2f2f2f',
    darkgray  = '#202020',
    lightgray = '#434343'
}

local rem_theme = {
    normal = {
        a = { bg = rem_colors.white, fg = rem_colors.blue, gui = 'bold' },
        b = { bg = rem_colors.darkwhite, fg = rem_colors.blue },
        c = { bg = nil, fg = rem_colors.white },
    },
    insert = {
        a = { bg = rem_colors.gray, fg = rem_colors.darkwhite, gui = 'bold' },
        b = { bg = rem_colors.darkwhite, fg = rem_colors.blue },
        c = { bg = nil, fg = rem_colors.white },
    },
    visual = {
        a = { bg = rem_colors.gray, fg = rem_colors.magenta, gui = 'bold' },
        b = { bg = rem_colors.darkwhite, fg = rem_colors.blue },
        c = { bg = nil, fg = rem_colors.white },
    },
    replace = {
        a = { bg = rem_colors.gray, fg = rem_colors.magenta, gui = 'bold' },
        b = { bg = rem_colors.darkwhite, fg = rem_colors.red },
        c = { bg = nil, fg = rem_colors.white },
    },
    command = {
        a = { bg = rem_colors.blue, fg = rem_colors.magenta, gui = 'bold' },
        b = { bg = rem_colors.darkwhite, fg = rem_colors.gray },
        c = { bg = nil, fg = rem_colors.white },
    },
    inactive = {
        a = { bg = rem_colors.gray, fg = rem_colors.magenta, gui = 'bold' },
        b = { bg = rem_colors.darkwhite, fg = rem_colors.gray, gui = 'bold' },
        c = { bg = nil, fg = rem_colors.lightgray },
    },
}

local nf_colors = {
    color3 = '#2c3043',
    color6 = '#a1aab8',
    color7 = '#9b82ff', --'#82aaff',
    color8 = '#ae81ff',
    color0 = '#092236',
    color1 = '#ff5874',
    color2 = '#c3ccdc',
}

local nf_theme = {
    replace = {
        a = { fg = nf_colors.color0, bg = nf_colors.color1, gui = 'bold' },
        b = { fg = nf_colors.color2, bg = nf_colors.color3 },
        c = { fg = nf_colors.color6, bg = nil },
    },
    inactive = {
        a = { fg = nf_colors.color6, bg = nf_colors.color3, gui = 'bold' },
        b = { fg = nf_colors.color6, bg = nf_colors.color3 },
        c = { fg = nf_colors.color6, bg = nil },
    },
    normal = {
        a = { fg = nf_colors.color0, bg = nf_colors.color7, gui = 'bold' },
        b = { fg = nf_colors.color2, bg = nf_colors.color3 },
        c = { fg = nf_colors.color2, bg = nil },
    },
    visual = {
        a = { fg = nf_colors.color0, bg = nf_colors.color8, gui = 'bold' },
        b = { fg = nf_colors.color2, bg = nf_colors.color3 },
        c = { fg = nf_colors.color6, bg = nil },
    },
    insert = {
        a = { fg = nf_colors.color0, bg = nf_colors.color2, gui = 'bold' },
        b = { fg = nf_colors.color2, bg = nf_colors.color3 },
        c = { fg = nf_colors.color6, bg = nil },
    },
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'filename' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 'encoding' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.g.komau_italic = false

--vim.cmd.colorscheme("lavender") -- use with ai bg
--vim.cmd.colorscheme("base16-stella") -- use with purple anime girl bg
--vim.cmd.colorscheme("falcon") -- use with nullspaces
--vim.cmd.colorscheme("yuyuko") -- use with rem bg
vim.cmd.colorscheme("komau")


-- vim.cmd.colorscheme("gruber-darker")
-- vim transparent
--vim.g.transparent_groups            = { 'Normal', 'Comment', 'Constant', 'Special', 'Identifier',
--    'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
--    'Function', 'Conditional', 'Repeat', 'Operator', 'Structure',
--    'LineNr', 'NonText', 'SignColumn', 'CursorLineNr', 'EndOfBuffer', 'Pmenu' }

--omnisharp
vim.g.OmniSharp_server_path         = 'C:\\Users\\ondar\\!language_servers\\Omnisharp\\OmniSharp.exe'
vim.g.OmniSharp_selector_findusages = 'fzf'


-- cpp higlight

vim.g.lsp_cxx_hl_use_text_props     = 1
vim.g.cpp_class_scope_highlight     = 1
vim.g.cpp_member_variable_highlight = 1
vim.g.cpp_class_decl_highlight      = 1
vim.g.cpp_posix_standard            = 1
vim.g.cpp_concepts_highlight        = 1


--[[ Mappings ]]

vim.api.nvim_set_keymap('n', '<C-k>', '<up>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<down>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<left>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<right>', { noremap = true })

vim.g.floaterm_keymap_toggle = '<Space>tt'
vim.g.floaterm_keymap_kill   = '<Space>tk'


-- [[ autocommands ]]

--[[ coc.nvim ]]
vim.g.coc_global_extensions = { 'coc-lua', 'coc-java', 'coc-discord-rpc',
    'coc-cmake', 'coc-json', 'coc-highlight', 'coc-clangd', 'coc-tabnine' }
-- Some servers have issues with backup files, see #649
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<shift>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })


-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })


-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})


-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })


-- Formatting selected code
keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })


-- Setup formatexpr specified filetype(s)
vim.api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts = { silent = true, nowait = true }
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

-- Remap keys for apply code actions at the cursor position.
keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
-- Remap keys for apply source code actions for current file.
keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
-- Apply the most preferred quickfix action on the current line.
keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true, expr = true }
keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
keyset("i", "<C-f>",
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
keyset("i", "<C-b>",
    'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })


-- Add `:Format` command to format current buffer
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = { silent = true, nowait = true }
-- Show all diagnostics
keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions
keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
-- Show commands
keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols
keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item
keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item
keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
