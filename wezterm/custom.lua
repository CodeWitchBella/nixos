
local wezterm = require 'wezterm'

-- This is the module table that we will export
local module = {}

function module.apply_to_config(config)
  --config.color_scheme = 'Batman'
  config.font = wezterm.font_with_fallback { 'FiraCode Nerd Font' }
  config.font_size = 12;
end

-- return our module table
return module
