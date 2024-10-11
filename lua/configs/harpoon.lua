local harpoon = require "harpoon"
-- REQUIRED
harpoon:setup()

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}

  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  local make_finder = function()
    local paths = {}

    for _, item in ipairs(harpoon_files.items) do
      table.insert(paths, item.value)
    end

    return require("telescope.finders").new_table {
      results = paths,
    }
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      set_env = conf.set_env,
      color_devicons = true,
      previewer = conf.file_previewer {},
      grep_previewer = conf.grep_previewer {
        color_devicons = true
      },
      qflist_previewer = conf.qflist_previewer {
        color_devicons = true
      },
      layout_config = {
        preview_cutoff = 1,
        width = function(_, max_columns, _)
          return math.min(max_columns, 110)
        end,
        height = function(_, _, max_lines)
          return math.min(max_lines, 40)
        end,
      },
      attach_mappings = function(prompt_buffer_number, map)
        -- The keymap you need
        map("i", "<c-d>", function()
          local state = require "telescope.actions.state"
          local selected_entry = state.get_selected_entry()
          local current_picker = state.get_current_picker(prompt_buffer_number)

          -- This is the line you need to remove the entry
          harpoon:list():remove(selected_entry)
          current_picker:refresh(make_finder())
        end)

        return true
      end,
    })
    :find()
end
vim.keymap.set("n", "<C-e>", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })
