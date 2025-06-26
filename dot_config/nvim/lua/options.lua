require "nvchad.options"

vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
  pattern = "*.fish.tmpl",
  callback = function()
    vim.bo.filetype = "fish"
  end,
})
-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
