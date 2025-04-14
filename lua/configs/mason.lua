local opts = {
  ensure_installed = {
    --- language servers
    "gopls",
    "elixir-ls",
    "clangd",
    "ols",
    "lua-language-server",
    "clojure-lsp",
    --- formatters
    "stylua",
    "golines",
    "goimports",
    "goimports-reviser",
    "gofumpt",
    "cljfmt",
  },
  PATH = "skip",

  ui = {
    icons = {
      package_pending = " ",
      package_installed = "󰄳 ",
      package_uninstalled = " 󰚌",
    },

    keymaps = {
      toggle_server_expand = "<CR>",
      install_server = "i",
      update_server = "u",
      check_server_version = "c",
      update_all_servers = "U",
      check_outdated_servers = "C",
      uninstall_server = "X",
      cancel_installation = "<C-c>",
    },
  },

  max_concurrent_installers = 10,
}

return opts


