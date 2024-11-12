local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.color_scheme = 'Snazzy'
config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 13.0

config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}
config.hide_tab_bar_if_only_one_tab = true

config.send_composed_key_when_left_alt_is_pressed = true

-- Configure keys to move tabs around
config.keys = {
  { key = '{', mods = 'SHIFT|ALT', action = act.MoveTabRelative(-1) },
  { key = '}', mods = 'SHIFT|ALT', action = act.MoveTabRelative(1) },
}

return config
