-- gigtekconfig/plugins.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Theme & Icons
  { "folke/tokyonight.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          section_separators = "",
          component_separators = "",
        },
      })
    end,
  },

  -- Treesitter & Rainbow
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "python", "javascript", "html", "css", "bash", "json",
        },
        highlight = { enable = true },
        indent = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
        },
      })
    end,
  },
  { "HiPhish/nvim-ts-rainbow2" },

  -- Telescope
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- File Tree
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({})
    end,
  },

  -- Git
  { "tpope/vim-fugitive" },
  { "lewis6991/gitsigns.nvim", config = true },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 1
    end,
  },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", build = ":MasonUpdate", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "tsserver", "bashls" },
        automatic_installation = true,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
})

vim.cmd.colorscheme("tokyonight")

