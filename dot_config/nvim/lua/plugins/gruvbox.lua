return {
  {
    "ellisonleao/gruvbox.nvim",
    name = "gruvbox",
    lazy = true,
    config = function()
      vim.g.gruvbox_contrast_dark = "hard"
      vim.g.gruvbox_invert_selection = "0"
      vim.g.gruvbox_italic = true
      vim.g.gruvbox_italic_comments = true
      vim.g.gruvbox_italic_keywords = true
      vim.g.gruvbox_italic_functions = true
      vim.g.gruvbox_italic_variables = true
    end,
  },
}
