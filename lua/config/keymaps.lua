vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Toggle the file explorer
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Move cursor from file explorer to editor (Shift + Tab)
keymap.set("n", "<S-Tab>", "<cmd>wincmd w<CR>", { desc = "Move cursor to editor from file explorer" })

-- Move cursor from editor to file explorer (Shift + Tab)
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
-- keymap.set("n", "<leader>w", ":set wrap!<CR>", { desc = "Toggle line wrap" })


keymap.set("n", "ggq", ":set wrap!<CR>", { desc = "Toggle line wrap" })
-- -- Create file
-- keymap.set("n", "<C-n>", "<cmd>lua require('utils').create_file()<CR>", { desc = "Create file" })

-- -- Create directory
-- keymap.set("n", "<C-d>", "<cmd>lua require('utils').create_folder()<CR>", { desc = "Create directory" })

-- keymap.set("n", "<C-n>", function()
--     Util.terminal.open({ "lazysql" }, {
--       cwd = Util.root.get(),
--       ctrl_hjkl = false,
--       border = "rounded",
--       persistent = false,
--       title = "Lazysql",
--       title_pos = "center",
--     })
--   end, { desc = "Lazysql" })

keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")

