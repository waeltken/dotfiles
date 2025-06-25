require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")

-- GitHub Copilot
vim.keymap.set("n", "<leader>cc", ":CopilotChat<CR>", { desc = "Copilot Chat" })
vim.keymap.set("v", "<leader>cc", ":CopilotChat<CR>", { desc = "Copilot Chat with selection" })

-- Save and restore session mappings
vim.keymap.set("n", "<leader>qs", function()
  vim.cmd("mksession! ~/.vim/session.vim")
  vim.cmd("qa")
end, { desc = "Save session and quit all" })

vim.keymap.set("n", "<leader>qr", function()
  vim.cmd("source ~/.vim/session.vim")
end, { desc = "Reload session" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

