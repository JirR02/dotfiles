vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit out of insert mode" })
keymap.set("n", "<leader>q", "<cmd>wq<CR>", { desc = "Exit NeoVim and Save file" })
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>-", "gcc", { desc = "Toggle comment" })
