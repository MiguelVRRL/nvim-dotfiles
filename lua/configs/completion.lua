require("mini.completion").setup {
  width = 40,
  window = {
    info = { height = 25, width = 40, border = "rounded" },
    signature = { height = 25, width = 40, border = "rounded" },
  },
  delay = { completion = 40, info = 50, signature = 50 },
  lsp_completion = {
    source_func = "omnifunc",
    auto_setup = true,
    process_items = nil,
    snippet_insert = nil,
  },
}
