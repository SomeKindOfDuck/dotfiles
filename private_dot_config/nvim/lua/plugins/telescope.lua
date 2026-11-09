local set = vim.keymap.set

return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",

  dependencies = {
    'nvim-lua/plenary.nvim',
    "fannheyward/telescope-coc.nvim"
  },

  config = function()
    local builtin = require("telescope.builtin")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions

    set("n", "<leader>ff", builtin.find_files)
    set("n", "<leader>fl", builtin.current_buffer_fuzzy_find)
    set("n", "<leader>fb", builtin.buffers)
    set("n", "<leader>fg", builtin.live_grep)

    require('telescope').setup{
      defaults = {
        winblend = 30,
        pumblend = 30,
        sorting_strategy = "ascending",
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
        prompt_prefix = "   ",
        selection_caret = "󰋇 ",
        layout_config = {
          horizontal = { prompt_position = "top" },
          vertical = { mirror = false },
          width = 0.7,
          height = 0.7,
          preview_cutoff = 120,
        },

        mappings = {
          n = {
            ["q"] = actions.close,
            ["l"] = actions.select_default,
            ["h"] = fb_actions.goto_parent_dir,
            ["."] = fb_actions.toggle_hidden,
            ["cd"] = fb_actions.change_cwd,
          },
          i = {
            ["<C-k>"] = {
              actions.move_selection_previous,
              type = "action"
            },
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.close,
            ["<C-l>"] = actions.select_default,
            ["<C-h>"] = fb_actions.goto_parent_dir,
            ["<C-.>"] = fb_actions.toggle_hidden,
            ["<C-c><C-d>"] = fb_actions.change_cwd,
          }
        },

        file_ignore_patterns = {
          "^.git/",
          "^node_modules/",
          "^.venv",
          "%.png",
          "%.jpg",
          "%.pdf",
          "%.gif",
        },
      },

      pickers = {
        find_files = {
          -- theme = "dropdown",
          hidden = true,
          preview = true,
          find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
        },

        live_grep = {
          hidden = true,
          preview = true,
          find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
        },
      },

      buffers = { preview = false },

      extensions = {
        coc = { prefer_location = false },
        file_browser = { respect_gitignore = false }
      },
    }

    -- settings for coc
    set("n", "gd", "<CMD>Telescope coc definitions<CR>", { silent = true })
    set("n", "gt", "<CMD>Telescope coc type_definitions<CR>", { silent = true })
    set("n", "gr", "<CMD>Telescope coc references<CR>", { silent = true })
    set("n", "<leader>fd", "<CMD>Telescope coc diagnostics<CR>", { silent = true })

    require("telescope").load_extension("coc")
    require("telescope").load_extension("file_browser")
    require('telescope').load_extension('fzf')
  end,
}
