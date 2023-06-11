local Util = require("marshmallow.util")

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        spelling = {
          enabled = false,
        },
      })

      require("which-key").register({
        f = {
          name = "Find",
        },
        g = {
          name = "Git",
        },
        s = {
          name = "Search",
        },
        c = {
          name = "Change",
        },
        t = {
          name = "Open term",
        },
        m = {
          name = "Map",
        },
        S = {
          name = "Sessions",
        },
      }, { prefix = "<leader>" })
    end,
  },
  {
    "Eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
  },
  {
    "gbprod/stay-in-place.nvim",
    opts = true,
    event = "VeryLazy",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      space_char_blankline = " ",
      show_current_context = true,
      char = "▎",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = vim.fn.executable("make") == 1,
      },
      "nvim-telescope/telescope-symbols.nvim",
    },
    keys = {
      { "<leader><space>", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      {
        "<leader>/",
        Util.telescope("live_grep"),
        desc = "Find in Files (Grep)",
      },
      { "<leader>:",       "<cmd>Telescope command_history<cr>",               desc = "Command History" },
      -- find
      {
        "<leader>ff",
        Util.telescope("files"),
        desc = "Find Files (root dir)",
      },
      { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      {
        "<leader>fc",
        Util.telescope("find_files", { cwd = "~/.config/nvim" }),
        desc = "Find Files (~/.config/nvim)",
      },
      {
        "<leader>fC",
        Util.telescope("find_files", { cwd = "~/.config/" }),
        desc = "Find Files (~/.config/)",
      },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",            desc = "Recent" },
      -- git
      {
        "<leader>gw",
        function()
          require("telescope").extensions.git_worktree.git_worktrees()
        end,
        desc = "Manage & Delete Worktrees",
      },
      {
        "<leader>gn",
        function()
          require("telescope").extensions.git_worktree.create_git_worktree()
        end,
        desc = "Create a worktree",
      },
      -- search
      { "<leader>sa", "<cmd>Telescope autocommands<cr>",              desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sC", "<cmd>Telescope commands<cr>",                  desc = "Commands" },
      {
        "<leader>sc",
        Util.telescope("live_grep", { cwd = "~/.config/nvim" }),
        desc = "Search in ~/.config/nvim",
      },
      { "<leader>sd", "<cmd>Telescope diagnostics<cr>",             desc = "Diagnostics" },
      { "<leader>sg", Util.telescope("live_grep"),                  desc = "Grep (root dir)" },
      { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",               desc = "Help Pages" },
      {
        "<leader>sH",
        "<cmd>Telescope highlights<cr>",
        desc = "Search Highlight Groups",
      },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                   desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>",                 desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>",                     desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>",               desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>",                    desc = "Resume" },
      { "<leader>sl", "<cmd>Telescope symbols<cr>",                   desc = "Symbols" },
      { "<leader>sw", Util.telescope("grep_string"),                  desc = "Word (root dir)" },
      { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
      {
        "<leader>ss",
        Util.telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        Util.telescope("lsp_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
    },
    config = function()
      require("telescope").setup({})

      pcall(require("telescope").load_extension, "fzf")
      require("telescope").load_extension("git_worktree")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      _signs_staged_enable = true,
      preview_config = {
        border = "rounded",
      },
      -- signs_staged_enable = true,
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    opts = true,
    keys = {
      { "<leader>st", "<cmd>TodoTelescope<CR>", desc = "Todo Comments" },
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
    version = false,
  },
  {
    "echasnovski/mini.move",
    version = false,
    keys = {
      "<M-h>",
      "<M-l>",
      "<M-j>",
      "<M-k>",
      {
        "<M-h>",
        mode = "v",
      },
      {
        "<M-l>",
        mode = "v",
      },
      {
        "<M-j>",
        mode = "v",
      },
      {
        "<M-h>",
        mode = "v",
      },
    },
    opts = {},
  },
  {
    "echasnovski/mini.map",
    version = false,
    dependencies = "lewis6991/gitsigns.nvim",
    keys = {
      {
        "<Leader>mc",
        function()
          require("mini.map").close()
        end,
        desc = "Close Map",
      },
      {
        "<Leader>mf",
        function()
          require("mini.map").toggle_focus()
        end,
        desc = "Toggle Map Focus",
      },
      {
        "<Leader>mo",
        function()
          require("mini.map").open()
        end,
        desc = "Open Map",
      },
      {
        "<Leader>mr",
        function()
          require("mini.map").refresh()
        end,
        desc = "Refresh Map",
      },
      {
        "<Leader>ms",
        function()
          require("mini.map").toggle_side()
        end,
        desc = "Toggle Map Side",
      },
      {
        "<Leader>mt",
        function()
          require("mini.map").toggle()
        end,
        desc = "Toggle Map",
      },
    },
    config = function()
      local map = require("mini.map")

      for _, key in ipairs({ "n", "N", "*", "#" }) do
        vim.keymap.set("n", key, key .. "<Cmd>lua MiniMap.refresh({}, {lines = false, scrollbar = false})<CR>")
      end

      map.setup({
        integrations = {
          map.gen_integration.builtin_search({
            search = "MiniMapSearch",
          }),
          map.gen_integration.diagnostic({
            error = "MiniMapDiagnosticError",
            warn = "MiniMapDiagnosticWarn",
            info = "MiniMapDiagnosticInfo",
            hint = nil,
          }),
          map.gen_integration.gitsigns({
            add = "GitSignsAdd",
            change = "GitSignsChange",
            delete = "GitSignsDelete",
          }),
        },
        symbols = {
          encode = map.gen_encode_symbols.block("3x2"),

          -- Scrollbar parts for view and line. Use empty string to disable any.
          scroll_line = "┃",
          scroll_view = "┃",
        },

        window = {
          show_integration_count = false,
        },
      })
    end,
  },
  {
    "echasnovski/mini.surround",
    version = false,
    keys = {
      "gza",
      "gzd",
      "gzf",
      "gzF",
      "gzh",
      "gzr",
      "gzn",
    },
    opts = {
      mappings = {
        add = "gza",        -- Add surrounding in Normal and Visual modes
        delete = "gzd",     -- Delete surrounding
        find = "gzf",       -- Find surrounding (to the right)
        find_left = "gzF",  -- Find surrounding (to the left)
        highlight = "gzh",  -- Highlight surrounding
        replace = "gzr",    -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
  },
  {
    "echasnovski/mini.comment",
    version = false,
    keys = {
      "gc",
      "gcc",
    },
    opts = true,
  },
  {
    "echasnovski/mini.cursorword",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.cursorword").setup()

      vim.cmd(":hi! MiniCursorwordCurrent guifg=NONE guibg=NONE gui=NONE cterm=NONE")
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    opts = true,
    event = "VeryLazy",
  },
  {
    "voldikss/vim-floaterm",
    cmd = "FloatermNew",
    lazy = true,
    keys = {
      {
        "<leader>tl",
        "<cmd>:FloatermNew --cwd=<root> --name=Lazygit --width=1.0 --height=1.0  lazygit<CR>",
        desc = "Open Lazygit",
      },
      {
        "<leader>tc",
        "<cmd>:FloatermNew --cwd=<root> --name=Chezmoi --width=1.0 --height=1.0 --auto_close=0 chezmoi cd<CR>",
        desc = "Open chezmoi",
      },
    },
  },
  {
    "rebelot/heirline.nvim",
    dependencies = { "catppuccin/nvim", "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
    event = "UiEnter",
    config = function()
      local heirline = require("heirline")
      local conditions = require("heirline.conditions")
      local utils = require("heirline.utils")
      local palette = require("catppuccin.palettes").get_palette()

      local colors = {
        bg = palette.base,
        fg = palette.text,
        surface0 = palette.surface0,
        surface1 = palette.surface1,
        surface2 = palette.surface2,
        subtext0 = palette.subtext0,
        red = palette.red,
        green = palette.green,
        yellow = palette.yellow,
        blue = palette.blue,
        peach = palette.peach,
        mauve = palette.mauve,
        pink = palette.pink,
        sky = palette.sky,
        cyan = palette.teal,
        dark = palette.mantle,
      }

      local ViMode = {
        init = function(self)
          self.mode = vim.fn.mode(1)
        end,
        provider = function(self)
          return "󱥰 " .. self.mode_names[self.mode] .. ""
        end,
        hl = function(self)
          local mode = self.mode:sub(1, 1)
          return { fg = self.mode_colors[mode], bold = true }
        end,
        update = {
          "ModeChanged",
          pattern = "*:*",
          callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
          end),
        },
      }

      ViMode = utils.surround({ "", "" }, "surface0", { ViMode })

      local FileNameBlock = {
        init = function(self)
          self.filename = vim.api.nvim_buf_get_name(0)
        end,
      }

      local FileIcon = {
        init = function(self)
          local filename = self.filename
          local extension = vim.fn.fnamemodify(filename, ":e")
          self.icon, self.icon_color =
              require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
        end,
        provider = function(self)
          return self.icon and (self.icon .. " ")
        end,
        hl = function(self)
          return { fg = self.icon_color }
        end,
      }

      local FileName = {
        provider = function(self)
          local filename = vim.fn.fnamemodify(self.filename, ":.")

          if vim.bo.filetype == "oil" then
            filename = vim.fn.fnamemodify(require("oil").get_current_dir(), ":p:~")
          end

          if filename == "" then
            return "[No Name]"
          end

          if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
          end
          return filename
        end,
        hl = { fg = utils.get_highlight("Directory").fg },
      }

      local FileFlags = {
        {
          condition = function()
            return vim.bo.modified
          end,
          provider = "[+]",
          hl = { fg = "green" },
        },
        {
          condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = "",
          hl = { fg = "orange" },
        },
      }

      local FileNameModifer = {
        hl = function()
          if vim.bo.modified then
            return { fg = "cyan", bold = true, force = true }
          end
        end,
      }

      FileNameBlock = utils.insert(
        FileNameBlock,
        FileIcon,
        utils.insert(FileNameModifer, FileName),
        FileFlags,
        { provider = "%<" }
      )

      local FileType = {
        provider = function()
          return string.upper(vim.bo.filetype)
        end,
        hl = { fg = utils.get_highlight("Type").fg, bold = true },
      }

      local Ruler = {
        -- %l = current line number
        -- %L = number of lines in the buffer
        -- %c = column number
        -- %P = percentage through file of displayed window
        provider = "%7(%l/%3L%):%2c %P",
        hl = {
          fg = "subtext0",
        },
      }

      local LSPActive = {
        condition = conditions.lsp_attached,
        update = { "LspAttach", "LspDetach" },
        provider = function()
          local names = {}
          for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
          end
          return table.concat(names, " ")
        end,
        hl = { fg = "green", bold = true },
      }

      local Diagnostics = {
        condition = conditions.has_diagnostics,
        static = {
          error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
          warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
          info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
          hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
        },
        init = function(self)
          self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
          self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
          self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
          self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        end,
        update = { "DiagnosticChanged", "BufEnter" },
        {
          provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
          end,
          hl = { fg = "red" },
        },
        {
          provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
          end,
          hl = { fg = "yellow" },
        },
        {
          provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
          end,
          hl = { fg = "blue" },
        },
        {
          provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
          end,
          hl = { fg = "cyan" },
        },
      }

      local Git = {
        condition = conditions.is_git_repo,
        init = function(self)
          self.status_dict = vim.b.gitsigns_status_dict
          self.has_changes = self.status_dict.added ~= 0
              or self.status_dict.removed ~= 0
              or self.status_dict.changed ~= 0
        end,
        hl = { fg = "peach" },
        {
          -- git branch name
          provider = function(self)
            return " " .. self.status_dict.head
          end,
          hl = { bold = true },
        },
        -- You could handle delimiters, icons and counts similar to Diagnostics
        {
          condition = function(self)
            return self.has_changes
          end,
          provider = "(",
        },
        {
          provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count)
          end,
          hl = { fg = "green" },
        },
        {
          provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count)
          end,
          hl = { fg = "red" },
        },
        {
          provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("~" .. count)
          end,
          hl = { fg = "yellow" },
        },
        {
          condition = function(self)
            return self.has_changes
          end,
          provider = ")",
        },
      }

      local HelpFileName = {
        condition = function()
          return vim.bo.filetype == "help"
        end,
        provider = function()
          local filename = vim.api.nvim_buf_get_name(0)
          return vim.fn.fnamemodify(filename, ":t")
        end,
        hl = { fg = colors.blue },
      }

      local ALIGN = { provider = "%=" }
      local SPACE = { provider = "  " }

      local StatusLine = {
        ViMode,
        SPACE,
        FileNameBlock,
        SPACE,
        HelpFileName,
        Git,
        SPACE,
        Diagnostics,
        ALIGN,
        LSPActive,
        SPACE,
        FileType,
        SPACE,
        Ruler,
        static = {
          mode_names = {
            n = "H",
            no = "H?",
            nov = "H?",
            noV = "H?",
            ["no\22"] = "H?",
            niI = "Hi",
            niR = "Hr",
            niV = "Hv",
            nt = "Ht",
            v = "V",
            vs = "Vs",
            V = "V_",
            Vs = "Vs",
            ["\22"] = "^V",
            ["\22s"] = "^V",
            s = "S",
            S = "S_",
            ["\19"] = "^S",
            i = "I",
            ic = "Ic",
            ix = "Ix",
            R = "R",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv",
            Rvc = "Rv",
            Rvx = "Rv",
            c = "C",
            cv = "Ex",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "T",
          },
          mode_colors = {
            n = "mauve",
            i = "sky",
            v = "green",
            V = "green",
            ["\22"] = "cyan",
            c = "peach",
            s = "yellow",
            S = "yellow",
            ["\19"] = "mauve",
            R = "red",
            r = "red",
            ["!"] = "red",
            t = "pink",
          },
          mode_color = function(self)
            local mode = conditions.is_active() and vim.fn.mode() or "n"
            return self.mode_colors_map[mode]
          end,
        },
      }

      heirline.setup({
        statusline = StatusLine,
        opts = {
          colors = colors,
        },
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Harpoon file",
      },
      {
        "<leader><C-space>",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Open Harpoon",
      },
      {
        "<leader>h",
        function()
          require("harpoon.ui").nav_prev()
        end,
        desc = "Harpoon prev",
      },
      {
        "<leader>l",
        function()
          require("harpoon.ui").nav_next()
        end,
        desc = "Harpoon next",
      },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      columns = {
        "icon",
      },
    },
    keys = {
      {
        "-",
        function()
          require("oil").open()
        end,
        desc = "Open parent directory",
      },
    },
    lazy = false,
  },
  {
    "tpope/vim-dadbod",
    lazy = false,
  },
  -- {
  --   "echasnovski/mini.starter",
  --   version = false,
  --   opts = {},
  --   config = function()
  --     local starter = require("mini.starter")

  --     local function footer()
  --       local timer = vim.loop.new_timer()

  --       timer:start(
  --         0,
  --         1000,
  --         vim.schedule_wrap(function()
  --           if vim.api.nvim_buf_get_option(0, "filetype") == "starter" then
  --             starter.refresh()
  --             timer:close()
  --           end
  --         end)
  --       )

  --       return function()
  --         local stats = require("lazy").stats()

  --         return "Loaded in ~" .. math.floor(stats.startuptime + 0.5)
  --       end
  --     end

  --     require("mini.starter").setup({
  --       header = function()
  --         return table.concat({}, "\n")
  --       end,
  --       footer = footer(),
  --       items = {
  --         starter.sections.recent_files(5, true, false),
  --         starter.sections.sessions(),
  --       },
  --       evaluate_single = true,
  --     })
  --   end,
  -- },
  {
    "echasnovski/mini.sessions",
    version = false,
    opts = {},
    keys = {
      {
        "<leader>Sr",
        function()
          require("mini.sessions").select()
        end,
        desc = "Read Session",
      },
      {
        "<leader>Sd",
        function()
          require("mini.sessions").select("delete")
        end,
        desc = "Delete Session",
      },
      {
        "<leader>Sw",
        function()
          local name = vim.fn.input({ prompt = "Session name (optional): ", default = "" })

          require("mini.sessions").write(name == "" and nil or name)
        end,
        desc = "Write Session",
      },
    },
    lazy = false,
  },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {},
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
  },
}
