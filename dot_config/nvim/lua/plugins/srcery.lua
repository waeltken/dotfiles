-- add srcery theme to the list of themes
return {
  {
    "srcery-colors/srcery-vim",
    lazy = true,
    name = "srcery",
    config = function()
      vim.g.srcery_italic_comments = true
      vim.g.srcery_italic_keywords = true
      vim.g.srcery_italic_functions = true
      vim.g.srcery_italic_variables = true
      vim.g.srcery_italic_strings = true
      vim.g.srcery_italic_numbers = true
      vim.g.srcery_italic_preproc = true
      vim.g.srcery_italic_types = true
    end,
  },
}
