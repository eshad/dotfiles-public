-- -- -- ~/.config/nvim/lua/util.lua
-- local M = {}

-- -- Terminal open function
-- M.terminal = {}
-- M.terminal.open = function(command, opts)
--     opts = opts or {}
--     local term_cmd = table.concat(command, " ")

--     -- Use nvim's terminal API to open a terminal
--     vim.cmd('split term://' .. term_cmd)
--     local bufnr = vim.fn.bufnr()
--     vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')

--     -- Example: you can set additional options here if needed
--     if opts.cwd then
--         vim.cmd('lcd ' .. opts.cwd)
--     end
--     if opts.border then
--         -- Handle border options if necessary
--     end
-- end

-- -- Function to get the root directory
-- M.root = {}
-- M.root.get = function()
--     return vim.fn.getcwd() -- This is a simple example. Adjust as needed.
-- end

-- return M
