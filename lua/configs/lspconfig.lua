local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

local M = {}
M.on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = vim.tbl_deep_extend("force",{}, capabilities)

-- lsps with default config
lspconfig.clangd.setup {
  autostart = true,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.gopls.setup {
  autostart = true,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}
lspconfig.ols.setup {
  autostart = true,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.lua_ls.setup {
  autostart = true,
  cmd = { "lua-language-server" },
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}
lspconfig.elixirls.setup {
  autostart = true,
  cmd = { "elixir-ls" },
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.clojure_lsp.setup {
  autostart = true,
  cmd = { "clojure-lsp" },
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.tinymist.setup {
  autostart = true,
  root_dir = function(fname)
    return util.path.dirname(fname)
  end,

  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

return M
