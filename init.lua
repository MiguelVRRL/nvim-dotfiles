vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy_nvim"

-- load plugins
require("lazy").setup({

  --- Onyx
  {
    "onyx-lang/onyx.vim",
    event = "VeryLazy",
    config = function(_, opts) end,
  },

  --- discord
  {
    "IogaMaster/neocord",
    event = "VeryLazy",
  },

  --- tabs

  {
    "nanozuki/tabby.nvim",
    event = "VimEnter", -- if you want lazy load, see below
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require "configs.tabby"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
    end,
  },
  --- themes
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require "configs.gruvbox"
    end,
  },

  --- visual

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      local icons = require("nvim-web-devicons").get_icons()
      icons.odin = {
        name = "Odin",
        icon = "",
        color = "#4084d4",
        cterm_color = "65",
      }
      icons.gleam = {
        name = "Gleam",
        icon = "",
        color = "#fdcae1",
        cterm_color = "66",
      }
      icons.astro = {
        name = "astro",
        icon = "󱓞",
        color = "#FF8000",
        cterm_color = "67",
      }
      return { override = icons }
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.lualine"
    end,
  },

  --- movement
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      return require "configs.telescope"
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    lazy = false,
    config = function()
      require "configs.harpoon"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = function()
      return require "configs.treesitter"
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  --- lsp
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    cmd = { "LspInfo", "LspInstall", "LspUninstall", "LspStart" },
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "configs.mason_nvim"
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      -- custom nvchad cmd to install all mason binaries listed
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd "Mason"
          local mr = require "mason-registry"

          mr.refresh(function()
            for _, tool in ipairs(opts.ensure_installed) do
              local p = mr.get_package(tool)
              if not p:is_installed() then
                p:install()
              end
            end
          end)
        end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },
  
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "configs.luasnip"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins

      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
    },
    opts = function()
      return require "configs.cmp_nvim"
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end,
  },
  {
    "onsails/lspkind.nvim",
  },
  { import = "plugins" },
}, lazy_config)

vim.filetype.add {
  extension = {
    onyx = "onyx",
  },
  pattern = {
    [".*onyx$"] = "onyx",
  },
}

vim.opt.swapfile = false
vim.o.showtabline = 2
vim.opt.number = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.lsp.set_log_level "off"
vim.cmd ":LspStart"
vim.o.termguicolors = true
vim.cmd [[colorscheme gruvbox ]]
vim.schedule(function()
  require "mappings"
end)

