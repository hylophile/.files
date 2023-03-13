local wezterm = require("wezterm")
local mux = wezterm.mux

local module = {}

local function contains(list, x)
	for _, v in pairs(list) do
		if v == x then
			return true
		end
	end
	return false
end

local function workspace_exists(ws)
	return contains(mux.get_workspace_names(), ws)
end

function module.create_or_switch_to_workspace(ws_name, callback)
	if not workspace_exists(ws_name) then
		callback(ws_name)
	end

	mux.set_active_workspace(ws_name)
end

return module
