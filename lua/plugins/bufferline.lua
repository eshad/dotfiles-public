-- return {
--   "akinsho/bufferline.nvim",
--    dependencies = { "nvim-tree/nvim-web-devicons" },
--   version = "*",
--   opts = {
--     options = {
--       mode = "tabs",
--         diagnostics = "nvim_lsp", -- Show LSP diagnostics
--         separator_style = { "", "" }, -- Separator style
--         modified_icon = "●", -- Icon for modified buffers
--         show_close_icon = false, -- Hide the close icon
--         show_buffer_close_icons = true, -- Show buffer close icons
--     },
--   },
-- }

return {
  "akinsho/bufferline.nvim",
  requires = "nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        mode = "tabline", -- Use 'tabline' mode for tab-like behavior
        diagnostics = "nvim_lsp", -- Show diagnostics from LSP client
        diagnostics_indicator = function(_, _, diagnostics)
          local icons = {
            error = " ",
            warning = " ",
            info = " ",
            hint = " ",
          }
          local result = {}
          for severity, count in pairs(diagnostics) do
            table.insert(result, icons[severity] .. count)
          end
          return table.concat(result, " ")
        end,
        offsets = {
          { filetype = "Neotree", text = "Nvim Tree", highlight = "Directory", text_align = "left" }
        },
        -- Customize icons for different filetypes
        indicator_icon = {
          default = "",
          modified = "",
          close = "",
          left = { close = "" },
        },
        -- Enable tabline mode
        mode = "tabline",
      },
    })
  end,
}