vim.g.mapleader = " "
local keymap = vim.keymap.set

keymap("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear highlights" })

keymap("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
keymap("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Git diff" })
keymap("n", "<leader>gh", ":DiffviewFileHistory<CR>", { desc = "Git history" })
keymap("n", "<leader>gb", ":GitBlameToggle<CR>", { desc = "Git Blame Toggle" })

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree" })

keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "References" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
