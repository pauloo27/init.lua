-- simple preferences :)

-- line numbers
vim.o.nu = true
vim.o.rnu = true
vim.o.cursorline = false

-- enable mouse
vim.o.mouse = "a"

-- <Tab> size and behavior
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- more "natural" spliting behavior
vim.o.splitbelow = true
vim.o.splitright = true

-- show line at column 80
vim.o.colorcolumn = "80"

-- allow for :find <file> to search in subdirectories
vim.o.path = vim.o.path .. "**"
-- ignore node_modules
vim.o.wildignore = vim.o.wildignore .. "*/node_modules/*"

-- keep undo history in the disk so it persists between sessions
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.cache/undodir")

-- something related to color
vim.o.termguicolors = true
