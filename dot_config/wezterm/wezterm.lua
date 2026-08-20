-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()
config.enable_kitty_keyboard = wezterm.target_triple ~= "x86_64-pc-windows-msvc"

config.launch_menu = {}
local launch_menu = config.launch_menu

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_domain = "WSL:Ubuntu"
	-- config.default_prog = { "fish", "-l" }
	table.insert(launch_menu, {
		label = "PowerShell (oh-my-posh)",
		args = {
			"pwsh.exe",
			"-NoLogo",
			"-NoExit",
			"-Command",
			"oh-my-posh init pwsh | Invoke-Expression",
		},
		domain = { DomainName = "local" },
	})
	config.keys = config.keys or {}
	table.insert(config.keys, { key = "Enter", mods = "SHIFT", action = act.SendString("\x1b[13;2u") })
	table.insert(config.keys, { key = "Enter", mods = "ALT", action = act.SendString("\x1b[13;3u") })

	-- Work around broken shifted printable input on Windows when kitty keyboard
	-- protocol is enabled in WezTerm. Pi/OMP only need the modified Enter
	-- sequences, so forward those explicitly while leaving normal text input in
	-- the legacy path.
else
	config.default_domain = "local"
end

for tab = 1, 9 do
	table.insert(config.keys, {
		key = tostring(tab),
		mods = "CTRL|SHIFT",
		action = act.ActivateTab(tab - 1),
	})
end
table.insert(config.keys, {
	key = "H",
	mods = "CTRL|SHIFT",
	action = act.ActivateTabRelative(-1),
})
table.insert(config.keys, {
	key = "L",
	mods = "CTRL|SHIFT",
	action = act.ActivateTabRelative(1),
})
-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 34

config.enable_scroll_bar = true
config.scrollback_lines = 15000

-- or, changing the font size and color scheme.
config.font_size = 15
config.font = wezterm.font_with_fallback({
	{ family = "CaskaydiaMono Nerd Font Mono" },
	"Symbols Nerd Font Mono",
})
config.color_scheme = "Catppuccin Mocha"

-- apprearance

-- config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- Finally, return the configuration to wezterm:
return config
