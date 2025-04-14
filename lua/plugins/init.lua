return {
  --- tabs

  {
    "nanozuki/tabby.nvim",
    event = "VimEnter",
    config = function()
      require "configs.tabby"
    end,
  },
  --- ui
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require "configs.gruvbox"
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require "configs.lualine"
    end,
  },
  {
    "echasnovski/mini.icons",
    version = "*",
    event = "VeryLazy",
    config = function()
      require "configs.icons"
    end,
  },

  --- movement
  {
    "stevearc/conform.nvim",
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
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
      return require "configs.nvimtree"
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
      require "configs.mason"
    end,
    config = function(_, opts)
      require("mason").setup(opts)

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
    "echasnovski/mini.completion",
    version = "*",
    event = "VeryLazy",
    config = function()
      require "configs.completion"
    end,
  },
}
