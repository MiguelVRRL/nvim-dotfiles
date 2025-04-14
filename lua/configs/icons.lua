require("mini.icons").setup {
  filetype = {
    ["odin"] = { glyph = "", hl = "MiniIconsAzure" },
    ["gleam"] = { glyph = "", hl = "MiniIconsAzure" },
    ["astro"] = { glyph = "󱓞", hl = "MiniIconsAzure" },
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" }),
  },
}
require("mini.icons").mock_nvim_web_devicons()
require("mini.icons").tweak_lsp_kind()
