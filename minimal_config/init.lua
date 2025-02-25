
--[[
        --using one instance of neovim--
Server:
    nvim --listen (servername) [files]

Joining to server:
    nvim --server (servername) --remote [files]

Getting servername:
    :echo v:servername
]]

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

    -- Braces & Brackets movement
    { modes = { "n", "o", "x" }, lhs = "x",          rhs = "%" },
    { modes = { "n", "o", "x" }, lhs = ",c",         rhs = "[{" },
    { modes = { "n", "o", "x" }, lhs = ".c",         rhs = "]}" },
    { modes = { "n", "o", "x" }, lhs = ",b",         rhs = "[(" },
    { modes = { "n", "o", "x" }, lhs = ".b",         rhs = "])" },

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
    { modes = { "n", "o", "x" }, lhs = "cc",         rhs = "cc" },  --[[ cut fix,
    cutlass deletes with c, which is not comfotable for me]]

    -- fixes
    { modes = { "n", "o", "x" }, lhs = "ci",         rhs = "ci" },
    { modes = { "n", "o", "x" }, lhs = "yi",         rhs = "yi" },
    { modes = { "n", "o", "x" }, lhs = "vi",         rhs = "vi" },
    { modes = { "n", "o", "x" }, lhs = "gd",         rhs = "gd" },
    { modes = { "n", "o", "x" }, lhs = "di",         rhs = "\"_di" },

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
    { modes = { "v" },           lhs = "B",          rhs = "A" },

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
    { modes = { "t", "i" },      lhs = "<C-w><ESC>", rhs = "<C-\\><C-n>" },
    -- Disable spawning empty buffer
    { modes = { "n" },           lhs = "<C-w><C-n>", rhs = "<nop>" },
    
    --other
    { modes = { "n" },           lhs = "<M-d>",  rhs = "<cmd>lua vim.diagnostic.open_float()<CR>" },
    { modes = { "n" },           lhs = ";",  rhs = "q:" },
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

--[[ Editor ]]
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("syntax on")
vim.cmd("filetype on")
vim.cmd("filetype indent on")
vim.cmd("set t_Co=256")
vim.cmd("command B buffers")
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
--vim.cmd("set noshowmode")

-- english lang
if vim.uv.os_uname().sysname == "Windows_NT" then
    vim.api.nvim_exec('language en_US', true)
end

-- tab options
vim.opt.expandtab   = true
vim.opt.tabstop     = 4
vim.opt.shiftwidth  = 4
vim.opt.autoindent  = true
vim.opt.smarttab    = true
vim.opt.softtabstop = 2
vim.opt.cindent     = true

---------   theme  ---------
vim.o.background = "dark"
vim.opt.termguicolors = true
vim.opt.background = "dark"
