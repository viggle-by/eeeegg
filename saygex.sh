#!/bin/bash

REPO_DIR="gigtekconfig"
NVIM_DIR="$REPO_DIR/nvim"
LUA_DIR="$NVIM_DIR/lua/gigtekconfig"

echo "📁 Creating repo structure..."
mkdir -p "$LUA_DIR"

echo "📄 Creating README.md..."
cat > "$REPO_DIR/README.md" <<EOF
# gigtekconfig

🧠 A modern Neovim configuration built with:
- 🌈 Treesitter + Rainbow
- 📁 Nvim-tree
- 💬 Git integration (blame, signs, diff)
- 💻 LSP + Autocomplete
- 🎨 Tokyonight theme
- 🚀 Easy setup with \`setup-gigtekconfig.sh\`
EOF

echo "📄 Creating LICENSE (MIT)..."
cat > "$REPO_DIR/LICENSE" <<EOF
MIT License

Copyright (c) $(date +%Y)

Permission is hereby granted, free of charge, to any person obtaining a copy...
[LICENSE TRUNCATED FOR BREVITY]
EOF

echo "📄 Creating setup-gigtekconfig.sh..."
cp ./setup-gigtekconfig.sh "$REPO_DIR/setup-gigtekconfig.sh"

echo "📄 Creating Neovim config files..."

cat > "$NVIM_DIR/init.lua" <<EOF
require("gigtekconfig.core")
EOF

cat > "$LUA_DIR/core.lua" <<EOF
require("gigtekconfig.options")
require("gigtekconfig.keymaps")
require("gigtekconfig.plugins")
require("gigtekconfig.lsp")
EOF

cat > "$LUA_DIR/options.lua" <<EOF
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
EOF

cat > "$LUA_DIR/keymaps.lua" <<EOF
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
EOF

cat > "$LUA_DIR/plugins.lua" <<'EOF'
-- (Paste full plugins.lua content from earlier here. Omitted for brevity.)
EOF

cat > "$LUA_DIR/lsp.lua" <<EOF
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = { "lua_ls", "pyright", "tsserver", "bashls" }

for _, server in ipairs(servers) do
  lspconfig[server].setup({
    capabilities = capabilities,
  })
end

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
  capabilities = capabilities,
})
EOF

echo "✅ Repo folder '$REPO_DIR' created."

echo "💡 To initialize Git and push to GitHub:"
echo ""
echo "   cd $REPO_DIR"
echo "   git init"
echo "   git add ."
echo "   git commit -m 'Initial commit: gigtekconfig'"
echo "   gh repo create gigtekconfig --public --source=. --remote=origin --push"