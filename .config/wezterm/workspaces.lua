local wezterm = require("wezterm")
local mux = wezterm.mux

local ws = require("workspace-helpers")

local module = {}

function module.register()
	wezterm.on("spawn-ws3", function(window, pane)
		ws.create_or_switch_to_workspace("eaa", function(ws_name)
			local eaa_dir = os.getenv("HOME") .. "/code/fisa/eaa"

			local tab, ui_pane, eaa_window = mux.spawn_window({
				workspace = ws_name,
				cwd = eaa_dir,
			})
			ui_pane:send_text("eaa ui\n")

			local eaa_logs_pane = ui_pane:split({
				direction = "Right",
				size = 0.8,
				cwd = eaa_dir,
			})
			eaa_logs_pane:send_text("eaa logs\n")

			local uic_pane = ui_pane:split({
				direction = "Bottom",
				size = 0.5,
				cwd = eaa_dir,
			})
			uic_pane:send_text("eaa uic build:watch\n")

			tab:set_title("EAA")
			eaa_window:set_config_overrides({
				font_size = 15.0,
			})

			local _, _, _ = eaa_window:spawn_tab({
				cwd = eaa_dir,
			})
		end)
		-- local tab, pane, window = mux.spawn_window({
		-- 	workspace = "automation",
		-- 	-- args = { "ssh", "vault" },
		-- })
	end)

	wezterm.on("spawn-ws4", function(window, pane)
		ws.create_or_switch_to_workspace("across", function(ws_name)
			local ax_dir = os.getenv("HOME") .. "/code/fisa/ax"
			local ax_ui_dir = os.getenv("HOME") .. "/code/fisa/ax-ui"

			local tab, ui_pane, ax_window = mux.spawn_window({
				workspace = ws_name,
				cwd = ax_dir,
			})
			ui_pane:send_text("ax ui\n")

			local ax_logs_pane = ui_pane:split({
				direction = "Right",
				size = 0.8,
				cwd = ax_dir,
			})
			ax_logs_pane:send_text("ax logs\n")

			local be_pane = ui_pane:split({
				direction = "Bottom",
				size = 0.3,
				cwd = ax_dir,
			})
			be_pane:send_text("ax be\n")

			local uic_pane = ui_pane:split({
				direction = "Bottom",
				size = 0.3,
				cwd = ax_dir,
			})
			uic_pane:send_text("ax uic build:watch\n")

			tab:set_title("ax")
			ax_window:set_config_overrides({
				font_size = 15.0,
			})

			local _, _, _ = ax_window:spawn_tab({
				cwd = ax_dir,
			})
			local _, _, _ = ax_window:spawn_tab({
				cwd = ax_ui_dir,
			})
		end)
		-- local tab, pane, window = mux.spawn_window({
		-- 	workspace = "automation",
		-- 	-- args = { "ssh", "vault" },
		-- })
	end)
end

return module
