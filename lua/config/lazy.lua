local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = "solarized-osaka",
        news = {
          lazyvim = true,
          neovim = true,
        },
      },
    },
    -- nvim-notify plugin configuration
    {
      "rcarriga/nvim-notify",
      config = function()
        require("notify").setup({
          stages = "fade_in_slide_out",
          timeout = 5000,
          background_colour = "#000000",
          icons = {
            ERROR = "",
            WARN = "",
            INFO = "",
            DEBUG = "",
            TRACE = "✎",
          },
        })
        vim.notify = require("notify")
      end,
    },
    -- nvim-lsputils plugin configuration
    {
      "RishabhRD/nvim-lsputils",
      requires = { "RishabhRD/popfix" },
      config = function()
        -- No need to configure lsputils here
      end,
    },

    -- Add DAP plugins
    {
      "mfussenegger/nvim-dap",
      -- No setup function needed here
    },
    {
      "nvim-neotest/nvim-nio",
      -- No setup function needed here
    },
    {
      "rcarriga/nvim-dap-ui",
      requires = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
      },
      config = function()
        require("dapui").setup()
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      config = function()
        require("nvim-dap-virtual-text").setup()
      end,
    },
    {
      "leoluz/nvim-dap-go",
      config = function()
        require("dap-go").setup()
      end,
    },

    -- Language specific DAP configurations
    {
      "mfussenegger/nvim-dap-python",
      config = function()
        require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
      end,
    },
    {
      "mfussenegger/nvim-jdtls",
      config = function()
        -- Java DAP configuration will be handled later in `nvim-dap` setup
      end,
    },

    --TSUpdateConfig
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = "maintained", -- Or a list of languages you want to install
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          indent = {
            enable = true,
          },
        })
      end,
    },

    -- Aerial plugin configuration
    {
      "stevearc/aerial.nvim",
      config = function()
        require("aerial").setup({
          backends = { "lsp", "treesitter", "markdown" },
          close_behavior = "auto",
          min_width = 20,
          max_width = 40,
          show_guides = true,
          guide_indent = 4,
          default_direction = "prefer_right",
          update_events = "TextChanged,InsertLeave",
        })
        vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>AerialToggle!<CR>", { noremap = true, silent = true })
      end,
    },

    {
      "wbthomason/packer.nvim",
      config = function()
        require("packer").startup({
          use_async = false,
          auto_clean = false,
          display = {
            open_fn = function()
              return require("packer.util").float({ border = "rounded" })
            end,
          },
          function()
            -- Add your plugin configurations here
          end,
        })
      end,
    },
    {
      "neoclide/coc.nvim",
      branch = "release",
    },

    -- Ctags and Tagbar configuration
    {
      "ludovicchabant/vim-gutentags",
      config = function()
        vim.g.gutentags_enabled = 1
        vim.g.gutentags_ctags_executable = "ctags"
        vim.g.gutentags_ctags_tagfile = ".tags"
        vim.g.gutentags_project_root = { ".git", ".hg", ".svn" }
        vim.g.gutentags_ctags_extra_args = { "--tag-relative=yes", "--fields=+ailmnS" }
        vim.g.gutentags_generate_on_missing = 1
        vim.g.gutentags_generate_on_write = 1
      end,
    },

    {
      "preservim/tagbar",
      config = function()
        vim.g.tagbar_ctags_bin = "/opt/homebrew/bin/ctags"
        vim.api.nvim_set_keymap("n", "<F8>", ":TagbarToggle<CR>", { noremap = true, silent = true })
      end,
    },
    -- {
    --   "akinsho/nvim-bufferline.lua",
    --   config = function()
    --     require("bufferline").setup({
    --       options = {
    --         close_command = "bdelete %d", -- Command to close a buffer
    --         right_mouse_command = "bdelete %d", -- Right-click command to close a buffer
    --         diagnostics = "nvim_lsp", -- Show diagnostics from LSP client
    --         mode = "tabs",
    --         diagnostics_indicator = function(_, _, diagnostics)
    --           local icons = {
    --             error = " ",
    --             warning = " ",
    --             info = " ",
    --             hint = " ",
    --           }
    --           local result = {}
    --           for severity, count in pairs(diagnostics) do
    --             table.insert(result, icons[severity] .. count)
    --           end
    --           return table.concat(result, " ")
    --         end,
    --         offsets = { { filetype = "NvimTree", text = "Explorer", highlight = "Directory", text_align = "left" } },
    --         -- Custom icon for each file type
    --         custom_filter = function(buf_number)
    --           -- Exclude certain buffers from the bufferline
    --           local exlude_ft = { "NvimTree", "packer", "qf" }
    --           local ft = vim.api.nvim_buf_get_option(buf_number, "filetype")
    --           return not vim.tbl_contains(exlude_ft, ft)
    --         end,
    --         -- Configure icons for different filetypes
    --         indicator_icon = {
    --           default = "",
    --           modified = "",
    --           close = "",
    --           left = { close = "" },
    --         },
    --         -- Customize icons for specific filetypes
    --         icon_custom_colors = true,
    --       },
    --     })
    --   end,
    -- },
    -- {
    --  "romgrk/barbar.nvim",
    --  config = function()
    --    require("bufferline").setup({})
    --  end,
    -- },

    -- import any extras modules here
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "lazyvim.plugins.extras.lang.tailwind" },
    { import = "lazyvim.plugins.extras.coding.copilot" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.vscode" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
    { import = "lazyvim.plugins.extras.test.core" },
    { import = "lazyvim.plugins.extras.coding.yanky" },
    { import = "lazyvim.plugins.extras.editor.mini-files" },
    -- { import = "lazyvim.plugins.extras.bufferline" },
    -- { import = "lazyvim.plugins.extras.util.project" },
    { import = "plugins" },
  },

  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  dev = {
    path = "~/.ghq/github.com",
  },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    cache = {
      enabled = true,
      -- disable_events = {},
    },
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    custom_keys = {
      ["<localleader>d"] = function(plugin)
        dd(plugin)
      end,
    },
  },
  debug = false,
})

-- Load the SCP handler
local scp_handler = require("scp_handler")

-- Set up the BufReadCmd autocommand for scp://*
vim.cmd([[
    augroup SCPHandler
        autocmd!
        autocmd BufReadCmd scp://* lua require('scp_handler').handle_scp(vim.fn.expand('<afile>'))
    augroup END
]])

-- local utils = require("util")
local utils = require("config/keymaps")

-- Set up key mapping for creating a file or directory
