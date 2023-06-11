return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
          max_lines = 2,
          mode = "topline",
        },
      },
    },
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    config = function()
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "cpp",
          "go",
          "lua",
          "python",
          "rust",
          "typescript",
          "vim",
          "tsx",
          "javascript",
          "css",
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
          },
        },
        indent = { enable = true, disable = { "python" } },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>."] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>,"] = "@parameter.inner",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>."] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>,"] = "@parameter.inner",
            },
          },
        },
      })
    end,
  },
}
