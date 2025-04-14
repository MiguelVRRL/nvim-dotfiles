local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "golines", "gofumpt", "goimports", "goimports-reviser" },
    clojure = { "cljfmt" },
  },
  formatters = {
    stylua = {
      prepend_args = { "--indent-width", "2" },
    },
  },
}

require("conform").setup(options)
