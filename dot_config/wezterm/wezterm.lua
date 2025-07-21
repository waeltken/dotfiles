-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_domain = "WSL:Ubuntu"

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

config.enable_scroll_bar = true
config.scrollback_lines = 15000

-- or, changing the font size and color scheme.
config.font_size = 13
config.font = wezterm.font("CaskaydiaCove NFM")
config.color_scheme = "Catppuccin Mocha"

-- apprearance

-- config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- Finally, return the configuration to wezterm:
return config
