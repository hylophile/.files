This module allows you to save the layout of the current OS window to a file and load it on demand. All tabs and panes are saved along with their current working directory and the running program / shell command.

Note that recreating panes isn't implemented in the smartest possible way - the first pane will be split to the right repeatedly. As such, recreating more than 2-3 panes won't yield the best results. I mostly use this module for recreating multiple running programs (file watchers, viewers, logs...) in various tabs to easily jump back into a project, so I haven't had a need for accurate pane recreation yet.

# Setup

- Put `layouts.lua` into your `wezterm` config dir, e.g. `~/.config/wezterm/layouts.lua`
- Create a `layouts` directory in your config dir, e.g. `mkdir ~/.config/wezterm/layouts` (this could be automated)
- In your `~/.config/wezterm/wezterm.lua`, import the module and add keybindings for saving and loading layouts:
    ```lua
    local layouts = require("layouts")

    keys = { 
        { key = "F2", mods = "CTRL", action = wezterm.action_callback(layouts.serialize_window) },
        { key = "F3", mods = "CTRL", action = wezterm.action_callback(layouts.deserialize_window) },
        ...
    } -- or however your config.keys are defined
    ```
    With these, `Ctrl+F2` will ask you for a `<name>` and save the current window layout in `~/.config/wezterm/layouts/<name>.json`. It also shows you the currently saved layouts, so that you can easily overwrite them (and don't have to wonder how that one layout was called again).

    `Ctrl+F3` will show you a list of your saved layouts. Select one, and the window will be created.

- For recreating running programs, you'll need to set up [Shell
   Integration](https://wezfurlong.org/wezterm/shell-integration.html). See notes below.
   
   
# Notes on shell integration
We need shell integration / user variables because we want to recreate precisely
   the last shell command at the time of loading a layout, which is not
   necessarily the currently running process at the time of saving a layout.
   (E.g., with `ls | entr -s 'echo hi'`, the current process is just `entr` with
   `argv` set to `["-s","echo hi"]`). To fix that, the shell integration
   provides the `WEZTERM_PROG`.

One other integration is necessary for `zathura` (and maybe others): It sets the `cwd` to `""` when it's running, so we can't accurately reproduce open PDFs with it. That's why we need an additional `WEZTERM_CWD` user variable. Wezterm's upstream shell integration doesn't provide `WEZTERM_CWD`

If you use `fish`, this is all you need (in your `~/.config/fish/config.fish`):
```fish
function set_wezterm_user_vars --on-event fish_preexec
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_PROG (echo -n $argv | base64 --wrap 0)
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_CWD (echo -n (pwd) | base64 --wrap 0)
end

function unset_wezterm_prog --on-event fish_postexec
    printf "\033]1337;SetUserVar=%s=%s\007" WEZTERM_PROG ""
end
```
Note that we use `base64 --wrap 0` here, because base64 wraps after 76 characters, so long shell commands will be cut off when setting the user vars and won't be reproducible. (If you don't use `fish`, you'll need to adapt this in Wezterm's upstream shell integration, as it doesn't use this flag (PR?).)

To test whether shell integration is setup correctly:
- open only one terminal window
- run a command (because the user variables might not be set yet)
- open the Debug REPL (`Ctrl+Shift+L` by default) and compare:
```lua
> wezterm.mux:all_windows()[1]:tabs()[1]:panes()[1]:get_user_vars()
{
    "WEZTERM_CWD": "/home/hylo",
    "WEZTERM_PROG": "",
}
```
- run a long-running command and compare:
```lua
> wezterm.mux:all_windows()[1]:tabs()[1]:panes()[1]:get_user_vars()
{
    "WEZTERM_CWD": "/home/hylo",
    "WEZTERM_PROG": "ls | entr -s 'echo hi'",
}
```
- quit the long-running command and compare:
```lua
> wezterm.mux:all_windows()[1]:tabs()[1]:panes()[1]:get_user_vars()
{
    "WEZTERM_CWD": "/home/hylo",
    "WEZTERM_PROG": "",
}
```
