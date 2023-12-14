vim.opt.shiftwidth = 2

-- Install the lazy package manager if not found
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- Plugins
require("lazy").setup({
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    run = "make install_jsregexp",
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    config = true,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "catppuccin/nvim", name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
    },
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
  },
  {
    "f3fora/cmp-spell",
    dependencies = {
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-emoji",
      "hrsh7th/nvim-cmp",
    },
  },
  {
    "folke/neodev.nvim",
    opts = {}
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "kaarmu/typst.vim",
    lazy = false,
    ft = "typst",
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  "mhinz/vim-startify",
  "neovim/nvim-lspconfig",
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      theme = "gruvbox",
    },
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim"
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-media-files.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  "nvim-treesitter/nvim-treesitter",
  {
    "rmagatti/auto-session",
    opts = {
      auto_session_suppress_dirs = {
	"~/",
	"/",
	"~/Downloads",
	"~/code",
	"~/nosave",
      },
    },
  },
  {
    "rmagatti/session-lens",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "rmagatti/auto-session",
    },
  },
  {
    "renerocksai/telekasten.nvim",
    dependencies = {"nvim-telescope/telescope.nvim"}
  },
  {
    "rouge8/neotest-rust",
  },
  {
    "williamboman/mason.nvim",
  },
  {
    "yaocccc/nvim-hl-mdcodeblock.lua",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
})
vim.cmd.colorscheme "catppuccin"

require("mason").setup()

-- LSP
local lspconfig = require("lspconfig")
lspconfig.pyright.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.typst_lsp.setup {}
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
	globals = { "vim" }
      }
    }
  }
})
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, {desc = "Format code"})

-- nvim-cmp completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm {select = false },
  },
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    {
      name = "spell",
      option = {
	keep_all_entries = false,
	enable_in_context = function()
	  return true
	end,
      },
    },
  }
})

-- Global LSP mappings
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- null-ls isn't maintained anymore...
local null_ls = require("null-ls")
null_ls.setup {
  sources = {
    null_ls.builtins.diagnostics.ruff,
    null_ls.builtins.formatting.isort,
  }
}

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fc", builtin.command_history, {})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
local telescope = require("telescope")
telescope.setup {
  extensions = {
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg"},
      find_cmd = "rg",
    }
  }
}
telescope.load_extension("media_files")
telescope.load_extension("session-lens")

-- Telekasten
local zk_home = vim.fn.expand("~/zk")
require("telekasten").setup {
  home                = zk_home,
  dailies             = zk_home .. '/' .. 'daily',
  weeklies            = zk_home .. '/' .. 'weekly',
  templates           = zk_home .. '/' .. 'templates',
  template_new_daily  = zk_home .. '/' .. 'templates/daily.md',
  template_new_note   = zk_home .. '/' .. 'templates/new_note.md',
  template_new_weekly = zk_home .. '/' .. 'templates/weekly.md',
}
vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")
vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
vim.keymap.set("n", "<leader>zw", "<cmd>Telekasten goto_thisweek<CR>")
vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")
vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")

-- Harpoon
local harpoon = require("harpoon")
harpoon:setup {}
require("telescope").load_extension("harpoon")

-- gitsigns
require("gitsigns").setup {}

-- Spelling
vim.opt.spelllang = { "en", "fr" }
vim.opt.spell = true

-- Relative line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Comments
require("Comment").setup {}

-- Testing
require("neotest").setup {
  adapters = {
    require("neotest-rust")
  }
}
