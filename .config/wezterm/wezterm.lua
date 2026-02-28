local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local gui = wezterm.gui

local ws = require("workspace-helpers")
local layouts = require("layouts")

local dracula_colors = {
    background = "black",
    scrollbar_thumb = "#44475a",
    tab_bar = {
        background = "rgba(0,0,0,0.8)",
        active_tab = {
            bg_color = "#6272a4",
            fg_color = "#f8f8f2",
            intensity = "Normal",
            underline = "None",
            italic = false,
            strikethrough = false,
        },
        inactive_tab = {
            bg_color = "rgba(0,0,0,0.8)",
            fg_color = "#bfbfbf",
        },
        inactive_tab_hover = {
            bg_color = "#1e1f29",
            fg_color = "#bfbfbf",
            italic = true,
        },
        new_tab = {
            bg_color = "rgba(0,0,0,0.8)",
            fg_color = "#bfbfbf",
        },
        new_tab_hover = {
            bg_color = "#1e1f29",
            fg_color = "#bfbfbf",
            italic = true,
        },
    },
}

function override(t, k, v)
    local copy = {}
    for key, val in pairs(t) do
        copy[key] = val
    end
    copy[k] = v
    return copy
end

local dracula_colors_c = override(dracula_colors, "cursor_bg", "605a52")

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    return "   " .. tab.active_pane.title .. "   "
end)

function query_appearance()
    local success, stdout = wezterm.run_child_process({
        "darkman",
        "get",
    })
    if stdout:find("dark") then
        return "Dark"
    end
    return "Light"
end

wezterm.on("update-right-status", function(window, pane)
    local info = pane:get_foreground_process_info()
    if info then
        if string.find(info.executable, "hx") and query_appearance() == "Light" then
            window:set_config_overrides({
                colors = dracula_colors_c,
                font = wezterm.font("hylosevka", { weight = "Medium" }),
            })
        else
            window:set_config_overrides({
                nil,
            })
        end
    else
        window:set_right_status("")
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
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
    -- term = "wezterm",
    window_background_opacity = 0.8,
    -- text_background_opacity = 0.8,
    -- text_background_opacity = 0.8,
    switch_to_last_active_tab_when_closing_tab = true,
    --"Dracula",
    -- color_scheme = "Modus-Operandi-Deuteranopia",
    -- color_scheme = "Ef-Summer",
    -- color_scheme = "Ef-Reverie",
    -- color_scheme = "Ef-Spring",
    -- color_scheme = "rose-pine-dawn",
    -- color_scheme = "rose-pine",
    -- color_scheme = "Catppuccin Latte",
    -- color_scheme = "Papercolor Light (Gogh)",
    color_scheme = "Dracula",
    -- color_scheme = scheme_for_appearance(get_appearance()),
    -- font = wezterm.font("Agave"),
    font = wezterm.font("hylosevka", { weight = "Medium" }),
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
    colors = dracula_colors,
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

    leader = { mods = "CTRL", key = "m", timeout_milliseconds = 5000 },
    keys = {
        {
            key = "v",
            mods = "LEADER",
            action = wezterm.action.SplitPane({ direction = "Right" }),
        },
        {
            key = "d",
            mods = "LEADER",
            action = wezterm.action.CloseCurrentPane({ confirm = false }),
        },
        {
            key = "q",
            mods = "LEADER",
            action = wezterm.action.CloseCurrentPane({ confirm = false }),
        },
        {
            key = "a",
            mods = "LEADER",
            action = wezterm.action.PaneSelect({}),
        },
        {
            key = "m",
            mods = "LEADER",
            action = wezterm.action.ActivatePaneDirection("Next"),
        },
        {
            key = "h",
            mods = "LEADER",
            action = wezterm.action.SplitPane({ direction = "Down" }),
        },

        { key = "F2", mods = "CTRL", action = wezterm.action_callback(layouts.serialize_window) },
        { key = "F3", mods = "CTRL", action = wezterm.action_callback(layouts.deserialize_window) },
        { key = "x", mods = "ALT|CTRL|SHIFT", action = act.ActivateCommandPalette },
        { key = "=", mods = "CTRL", action = act.ResetFontSize },

        {
            key = "L",
            mods = "CTRL",
            action = act.Multiple({
                act.ClearScrollback("ScrollbackAndViewport"),
                act.SendKey({ key = "L", mods = "CTRL" }),
            }),
        },
        {
            key = "w",
            mods = "CTRL|SHIFT",
            action = wezterm.action.CloseCurrentTab({ confirm = false }),
        },
        {
            key = "Enter",
            mods = "ALT",
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = "n",
            mods = "CTRL",
            action = wezterm.action.SpawnWindow,
        },
    },
}

config.hyperlink_rules = wezterm.default_hyperlink_rules()

table.insert(config.hyperlink_rules, {
    regex = "~?(/?[^/ '\"`:~;]+/)+([^/ '\"`:~;]+)(:[0-9]+)?(:[0-9]+)?",
    format = "edit://$0",
})

wezterm.on("open-uri", function(window, pane, uri)
    local start, _ = uri:find("edit://")
    if start == 1 then
        local authority = uri:gsub("^edit://", "")
        local path, line, column = string.match(authority, "([^:]+):?(%d*):?(%d*)")
        local args = { "hx", authority }
        -- kak version
        -- local pos = ""
        -- if line ~= "" then pos = "+" .. line end
        -- if column ~= "" then pos = pos .. ":" .. column end
        -- if pos ~= "" then table.insert(args, pos) end
        -- wezterm.log_info(args)

        window:perform_action(
            wezterm.action.SpawnCommandInNewTab({
                args = args,
            }),
            pane
        )
        return false
    end
end)

return config
