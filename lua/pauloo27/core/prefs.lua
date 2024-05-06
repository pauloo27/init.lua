-- simple preferences
local o = vim.o

-- line numbers
o.nu = true
o.rnu = true

-- enable mouse
o.mouse = 'a'

-- <Tab> size and behavior
o.expandtab = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2

-- more "natural" spliting behavior
o.splitbelow = true
o.splitright = true

-- show line at column 80
o.colorcolumn = '80'

-- allow for :find <file> to search in subdirectories
o.path = o.path .. '**'
-- ignore node_modules
o.wildignore = o.wildignore .. '*/node_modules/*'

-- keep undo history in the disk so it persists between sessions
o.undofile = true
o.undodir = vim.fn.expand("~/.cache/undodir")
