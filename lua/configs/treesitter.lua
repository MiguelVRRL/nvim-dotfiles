local options = {
  ensure_installed = {
    --- defaults
    "lua",
    "luadoc",
    "printf",
    "vim",
"vimdoc",
    
        -- web dev
        "html",
        "css",
        "astro",
        "vue",
        "javascript",
        "typescript",
        "tsx",

        -- backend
        "go",
        "python",
        "htmldjango",
        "phpdoc",
        "php_only",

        -- functional
        "haskell",
        "haskell_persistent",
        "elixir",
        "gleam",
        "elm",
        "erlang",

        -- tools
        "cmake",
        "make",
        "gomod",
        "gowork",
        "gosum",
        "json",
        "toml",
        "yaml",
        "markdown",

        -- graphics
        "glsl",

        -- low level
        "c",
        "cpp",
        "odin",
        "rust",

  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
  
}

return options
