local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

local ws = require("workspace-helpers")
local layouts = require("layouts")

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  -- if tab.is_active then
  --   return {
  --     { Background = { Color = 'blue' } },
  --     { Text = ' ' .. tab.active_pane.title .. ' ' },
  --   }
  -- end
  -- return "   " .. tab.active_pane.current_working_dir .. "   "
  return "   " .. tab.active_pane.title .. "   "

  -- return "   " .. os.getenv("PWD") .. "   "
end)

-- wezterm.on("gui-startup", function(cmd)

--     -- allow `wezterm start -- something` to affect what we spawn
--     -- in our initial window
--     local args = {}
--     if cmd then
--         args = cmd.args
--     end
-- end)
--

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
-- local function get_appearance()
--   if wezterm.gui then
--     return wezterm.gui.get_appearance()
--   end
--   return "Dark"
-- end

-- local function scheme_for_appearance(appearance)
--   if appearance:find("Dark") then
--     return "Dracula"
--   else
--     -- return "Dracula"
--     return "Ef-Spring"
--   end
-- end

wezterm.on('user-var-changed', function(window, pane, name, value)
  if name == 'pane-select-mode' then window:perform_action(act.PaneSelect({}), pane)
  -- elseif name == '...' then ...
  end
end)

local config = {
  quick_select_patterns = {
    -- match things that look like sha1 hashes
    -- (this is actually one of the default patterns)
    "'.+'",
    "[^ ]{5,}",
  },
  quick_select_alphabet = "tnseriaodhcgmvkplbjfuwyq",

  ssh_domains = {
    {
      -- This name identifies the domain
      name = "mve",
      -- The hostname or address to connect to. Will be used to match settings
      -- from your ssh config file
      remote_address = "minivee",
      -- The username to use on the remote host
      username = "root",
    },
    {
      -- This name identifies the domain
      name = "beemo",
      -- The hostname or address to connect to. Will be used to match settings
      -- from your ssh config file
      remote_address = "beemo",
      -- The username to use on the remote host
      username = "pi",
    },
  },

  -- enable_wayland = false,
  -- front_end = 'WebGpu',
  foreground_text_hsb = {
    -- hue = 1.25,
    -- saturation = 0.9,
    -- brightness = 1.1,
  },
  hide_mouse_cursor_when_typing = false,
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  -- term = "wezterm",
  window_background_opacity = 0.8,
  -- text_background_opacity = 0.8,
  -- text_background_opacity = 0.8,
  switch_to_last_active_tab_when_closing_tab = true,
  --"Dracula",
  color_scheme = "Dracula",
  -- color_scheme = scheme_for_appearance(get_appearance()),
  -- font = wezterm.font("Agave"),
  font = wezterm.font("hylosevka"),
  -- font = wezterm.font("IosevkaHylo"),
  -- font = wezterm.font("CommitMono"),
  font_size = 14.0,
  use_fancy_tab_bar = false,
  -- tab_bar_at_bottom = true,
  tab_max_width = 100,
  window_close_confirmation = "NeverPrompt",
  enable_scroll_bar = true,
  default_cursor_style = "SteadyBar",
  audible_bell = "Disabled",
  window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = wezterm.font("Jost*"),
    -- The size of the font in the tab bar.
    -- Default to 10. on Windows but 12.0 on other systems
    font_size = 12.0,
    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = "#1e1f29",
    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = "#1e1f29",
  },
  colors = {
    background = "black",
    -- cursor_bg = "#f8f8f2",
    -- -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = "#f8f8f2",
    -- -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- -- Bar or Underline.
    cursor_border = "#f8f8f2",
    -- default_cursor_style = "SteadyUnderline",
    -- the foreground color of selected text
    -- selection_fg = "black",
    -- the background color of selected text
    -- selection_bg = "#fffacd",

    -- The color of the scrollbar "thumb"; the portion that represents the current viewport
    scrollbar_thumb = "#44475a",
    tab_bar = {
      -- The color of the strip that goes along the top of the window
      -- (does not apply when fancy tab bar is in use)
      background = "rgba(0,0,0,0.8)",
      -- The active tab is the one that has focus in the window
      active_tab = {
        -- The color of the background area for the tab
        bg_color = "#6272a4",
        -- The color of the text for the tab
        fg_color = "#f8f8f2",
        -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
        -- label shown for this tab.
        -- The default is "Normal"
        intensity = "Normal",
        -- Specify whether you want "None", "Single" or "Double" underline for
        -- label shown for this tab.
        -- The default is "None"
        underline = "None",
        -- Specify whether you want the text to be italic (true) or not (false)
        -- for this tab.  The default is false.
        italic = false,
        -- Specify whether you want the text to be rendered with strikethrough (true)
        -- or not for this tab.  The default is false.
        strikethrough = false,
      },
      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        -- bg_color = "#1e1f29",
        bg_color = "rgba(0,0,0,0.8)",
        fg_color = "#bfbfbf",
        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab`.
      },
      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        bg_color = "#1e1f29",
        fg_color = "#bfbfbf",
        italic = true,
        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab_hover`.
      },
      -- The new tab button that let you create new tabs
      new_tab = {
        -- bg_color = "#1e1f29",
        bg_color = "rgba(0,0,0,0.8)",
        fg_color = "#bfbfbf",
        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab`.
      },
      -- You can configure some alternate styling when the mouse pointer
      -- moves over the new tab button
      new_tab_hover = {
        bg_color = "#1e1f29",
        fg_color = "#bfbfbf",
        italic = true,
        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `new_tab_hover`.
      },
    },
  },
  inactive_pane_hsb = {
    saturation = 0.8,
    -- hue=2,
    brightness = 0.8,
  },
  window_padding = {
    left = 10,
    right = 0,
    top = 0,
    bottom = 0,
  },

leader = { mods = 'CTRL', key = 'm', timeout_milliseconds = 5000 },
  keys = {
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.SplitPane { direction = 'Right' },
  },
  {
    key = 'd',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = 'q',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = 'a',
    mods = 'LEADER',
    action = wezterm.action.PaneSelect { }
  },
  {
    key = 'm',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection 'Next'
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.SplitPane { direction = 'Down' },
  },

    { key = "F2", mods = "CTRL",           action = wezterm.action_callback(layouts.serialize_window) },
    { key = "F3", mods = "CTRL",           action = wezterm.action_callback(layouts.deserialize_window) },
    { key = "x",  mods = "ALT|CTRL|SHIFT", action = act.ActivateCommandPalette },
    { key = "=",  mods = "CTRL",           action = act.ResetFontSize },

    {
      key = "L",
      mods = "CTRL",
      action = act.Multiple({
        act.ClearScrollback("ScrollbackAndViewport"),
        act.SendKey({ key = "L", mods = "CTRL" }),
      }),
    },
    {
      key = 'w',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.CloseCurrentTab { confirm = false },
    },
    {
      key = 'Enter',
      mods = 'ALT',
      action = wezterm.action.DisableDefaultAssignment,
    },
    {
      key = 'n',
      mods = 'CTRL',
      action = wezterm.action.SpawnWindow,
    },
  },
}

config.hyperlink_rules = wezterm.default_hyperlink_rules()

table.insert(config.hyperlink_rules, {
  regex = "~?(/?[^/ \'\"`:~;]+/)+([^/ \'\"`:~;]+)(:[0-9]+)?(:[0-9]+)?",
  format = "edit://$0",
})

wezterm.on('open-uri', function(window, pane, uri)
  local start, _ = uri:find('edit://');
  if start == 1 then
    local authority = uri:gsub("^edit://", "")
    local path, line, column = string.match(authority, "([^:]+):?(%d*):?(%d*)")
    local args = {"hx", authority}
    -- kak version
    -- local pos = ""
    -- if line ~= "" then pos = "+" .. line end
    -- if column ~= "" then pos = pos .. ":" .. column end
    -- if pos ~= "" then table.insert(args, pos) end
    -- wezterm.log_info(args)

    window:perform_action(
      wezterm.action.SpawnCommandInNewTab {
        args = args
      },
      pane
    )
    return false;
  end
end)

return config
