local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- Sixel viewer tools:
--   macOS: brew install libsixel chafa
--   Arch Linux: pacman -S libsixel chafa
-- If img2sixel emits no image on Arch, prefer chafa -f sixels file.png.

local font_size_by_os = {
  macos = 15.0,
  linux = 10.0,
}

local function current_os()
  if wezterm.target_triple:find("darwin") then
    return "macos"
  end

  if wezterm.target_triple:find("linux") then
    return "linux"
  end

  return "default"
end

config.window_background_opacity = 0.7

config.font_size = font_size_by_os[current_os()] or 12.0

config.keys = {
  {
    key = "C",
    mods = "CTRL|SHIFT",
    action = act.CopyTo("Clipboard"),
  },
  {
    key = "V",
    mods = "CTRL|SHIFT",
    action = act.PasteFrom("Clipboard"),
  },
}

config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelectionOrOpenLinkAtMouseCursor("Clipboard"),
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "SHIFT",
    action = act.CompleteSelectionOrOpenLinkAtMouseCursor("Clipboard"),
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "ALT",
    action = act.CompleteSelection("Clipboard"),
  },
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "ALT|SHIFT",
    action = act.CompleteSelection("Clipboard"),
  },
  {
    event = { Up = { streak = 2, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("Clipboard"),
  },
  {
    event = { Up = { streak = 3, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("Clipboard"),
  },
}

return config
