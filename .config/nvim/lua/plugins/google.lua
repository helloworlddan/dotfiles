return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "vintharas/telescope-codesearch.nvim",
        url = "sso://user/vintharas/telescope-codesearch.nvim",
        keys = {
          {
            "<leader>fsf",
            "<cmd>Telescope codesearch find_files<cr>",
            desc = "Find codesearch files",
          },
          {
            "<leader>fsq",
            "<cmd>Telescope codesearch find_query<cr>",
            desc = "Find codesearch query",
          },
        },
        config = function()
          require("telescope").load_extension("codesearch")
        end,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "aktau/telescope-citc.nvim",
        url = "sso://user/aktau/telescope-citc.nvim",
        keys = {
          {
            "<leader>fcm",
            "<cmd>Telescope citc modified<cr>",
            desc = "Find citc modified",
          },
          {
            "<leader>fcw",
            "<cmd>Telescope citc workspaces<cr>",
            desc = "Find citc workspaces",
          },
        },
        config = function()
          require("telescope").setup({
            extensions = {
              citc = {
                ignore_files_match = nil, -- Display all modified files.
              },
            },
          })
        end,
      },
    },
  },
  {
    "nvim-lua/plenary.nvim",
    dependencies = {
      {
        "chmnchiang/google-comments",
        url = "sso://user/chmnchiang/google-comments",
        keys = {
          {
            "<leader>fgp",
            "<cmd>lua require('google.comments').goto_prev_comment()<cr>",
            desc = "Goto next comment",
          },
          {
            "<leader>fgn",
            "<cmd>lua require('google.comments').goto_next_comment()<cr>",
            desc = "Goto previous comment",
          },
          {
            "<leader>fgl",
            "<cmd>lua require('google.comments').goto_prev_comments()<cr>",
            desc = "Toggle line comments",
          },
          {
            "<leader>fga",
            "<cmd>lua require('google.comments').show_all_comments()<cr>",
            desc = "Show all comments",
          },
        },
        config = function()
          require("google.comments").setup({
            --- The command and args for fetching comments.
            --- Example: {'comments', '--arg1'}
            --- Refer to `get_comments.par --help` to see all the options.
            command = {
              "/google/bin/releases/editor-devtools/get_comments.par",
              "--full",
              "--json",
              "-x=''",
            },
            --- The name of the sign to show on the sign column.
            --- You might want to define one using `sign_define`.
            --- Example:
            ---   vim.fn.sign_define('COMMENTS_ICON', {text = ' '})
            ---   -- And then set `sign = 'COMMENTS_ICON'` in the options.
            sign = nil,
            --- Fetch the comments after calling `setup`.
            auto_fetch = true,
            display = {
              --- The width of the comment display window.
              width = 40,
              --- When showing file paths, use relative paths or not.
              relative_path = true,
              --- Enable viewing comments through floating window
              floating = false,
              --- Options used when creating the floating window.
              floating_window_options = require("google.comments.options").default_floating_window_options,
            },
          })
        end,
      },
    },
  },
  {
    url = "sso://user/fentanes/googlepaths.nvim",
    event = { "VeryLazy", "BufReadCmd //*", "BufReadCmd google3/*" },
    opts = {},
  },
  {
    url = "sso://user/fentanes/gcert.nvim",
    dependencies = {
      "rcarriga/nvim-notify", -- Optional
    },
    event = "VeryLazy",
    opts = {
      check_gcert_interval_ms = 10000,
      check_gcert_unfocused_interval_ms = 60000,
      autorun_gcert = false,
      gcert_executable = "gcert",
      split_size = 12,
      show_notifications = true,
      use_nvim_notify = true,
    },
  },
  {
    url = "sso://user/jackcogdill/nvim-figtree",
    keys = {
      {
        "<Leader>gf",
        function()
          require("figtree").toggle()
        end,
      },
    },
    opts = {
      -- see |figtree-configuration| for all possible options
    },
  },
  {
    url = "sso://user/rprs/buganizer.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      { url = "sso://user/vicentecaycedo/buganizer-utils.nvim" },
    },
    cmd = {
      "FindBugs",
      "ShowBugUnderCursor",
    },
  },
}
