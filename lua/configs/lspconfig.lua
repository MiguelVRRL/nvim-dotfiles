local lspconfig = require "lspconfig"
local configs = require "lspconfig.configs"
local cmp_lsp = require "cmp_nvim_lsp"

local M = {}
M.on_attach = function(client, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end
end

M.capabilities =
  vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

-- M.capabilities =
  -- vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities())



-- lsps with default config
lspconfig.clangd.setup {
  autostart = true,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}
lspconfig.rust_analyzer.setup {
  autostart = true,
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}
lspconfig.pyright.setup {
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

configs.onyx = {
  default_config = {
    cmd = { "onyx", "lsp" },
    filetypes = { "onyx" },
    root_dir = function(filename)
      local utils = require "lspconfig.util"
      return utils.search_ancestors(filename, function(path)
        if utils.path.is_file(utils.path.join(path, "onyx-lsp.kdl")) then
          return path
        end
        if utils.path.is_file(utils.path.join(path, "onyx-pkg.kdl")) then
          return path
        end
      end)
    end,
    settings = {},
  },
}

lspconfig.onyx.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

return M
