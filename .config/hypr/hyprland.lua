--------------------------------------------------------------------------------
-- Hyprland Lua Configuration
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- 1. Monitors
--------------------------------------------------------------------------------
local layout = "home-big"

local layouts = {
	["office-desk"] = {
		{ output = "eDP-1", mode = "1920x1200@60", position = "3840x0", scale = 1 },
		{ output = "DP-1", mode = "3840x2160@60", position = "0x0", scale = 1.0666 },
	},
	["home-big"] = {
		{ output = "eDP-1", mode = "1920x1200@60", position = "0x1440", scale = 1 },
		{ output = "DP-1", mode = "2560x1440@60", position = "0x0", scale = 1 },
	},
	["home-small"] = {
		{ output = "eDP-1", mode = "1920x1200@60", position = "1920x0", scale = 1 },
		{ output = "DP-1", mode = "1920x1080@60", position = "0x0", scale = 1 },
	},
	["dual-mirror"] = {
		{ output = "eDP-1", mode = "1920x1080@60", position = "0x0", scale = 1 },
		{ output = "DP-1", mode = "1920x1080@60", mirror = "eDP-1", position = "0x0", scale = 1 },
		{ output = "HDMI-A-1", mode = "1920x1080@60", mirror = "eDP-1", position = "0x0", scale = 1 },
	},
}

local selected_monitors = layouts[layout]
	or {
		{ output = "", mode = "preferred", position = "auto", scale = "auto" },
	}

for _, monitor_cfg in ipairs(selected_monitors) do
	hl.monitor(monitor_cfg)
end

--------------------------------------------------------------------------------
-- 2. Workspaces & Binds
--------------------------------------------------------------------------------
local spaces = {
	{ name = "bash", number = 1, key = "B", icon = "" },
	{ name = "vim", number = 2, key = "V", icon = "" },
	{ name = "docs", number = 3, key = "D", icon = "󱔗" },
	{ name = "cloud", number = 4, key = "G", icon = "" },
	{ name = "ai", number = 5, key = "A", icon = "" },
	{ name = "web", number = 6, key = "W", icon = "" },
	{ name = "mail", number = 7, key = "M", icon = "" },
	{ name = "calendar", number = 8, key = "C", icon = "" },
	{ name = "notes", number = 9, key = "N", icon = "" },
	{ name = "gvc", number = 10, key = "Z", icon = "" },
	{ name = "personal", number = 11, key = "P", icon = "" },
	{ name = "external", number = 12, key = "X", icon = "󰍺" },
}

-- Lookup table by workspace name for convenient access
local ws_by_name = {}
for _, item in ipairs(spaces) do
	ws_by_name[item.name] = item.number
	hl.bind("SUPER + " .. item.key, hl.dsp.focus({ workspace = item.number }))
	hl.bind("SUPER + SHIFT + " .. item.key, hl.dsp.window.move({ workspace = item.number }))
end

--------------------------------------------------------------------------------
-- 3. Chrome Profiles & Launchers
--------------------------------------------------------------------------------
local profiles = {
	default = 1,
	argolis = 2,
	personal = 3,
}

local launchers = {
	reload = "hyprctl reload",
	wall = "hyprpaper",
	panel = "waybar",
	terminal = "foot",
	editor = "foot -T editor bash -c 'source .bashrc && nvim && bash'",
	antigravity = "foot -T antigravity bash -c 'source .bashrc && agy && bash'",
	filemanager = "foot -T filemanager ranger",
	corne = "foot -T corne -H cat Code/github.com/helloworlddan/corne/layout.txt",
	switch_main = "foot bash -c 'source .bashrc && hswitchscreen'",
	switch_external = "foot bash -c 'source .bashrc && hswitchscreen DP-1'",
	screenlock = "hyprlock",
	idledaemon = "hypridle",
	menu = "wofi",
	imageeditor = "gimp",
	colorpicker = "hyprpicker",
	nightlight = "gammastep -p wayland -l 53:10",
	daw = "bitwig-studio",
	screenshot_file = "grim -g \"$(slurp)\" ~/shot-$(date +'%s').png",
	screenshot_clip = 'grim -g "$(slurp)" - | wl-copy',
	browser = "goto -p " .. profiles.default,
	browser_argolis = "goto -p " .. profiles.argolis,
	browser_personal = "goto -p " .. profiles.personal,
	mail = "goto -p " .. profiles.default .. " -g mail",
	mail_new = "goto -p " .. profiles.default .. " -u mail.google.com/mail/?view=cm&fs=1&tf=1",
	calendar = "goto -p " .. profiles.default .. " -g calendar",
	meet = "goto -p " .. profiles.default .. " -g meet",
	cloud = "goto -p " .. profiles.default .. " -g console.cloud",
	cloud_argolis = "goto -p " .. profiles.argolis .. " -g console.cloud",
	cloud_personal = "goto -p " .. profiles.personal .. " -g console.cloud",
	godocs = "goto -p " .. profiles.default .. " -u pkg.go.dev",
	sparkplug = "goto -p " .. profiles.default .. " nucleus:sparkplug",
	excalidraw = "goto -p " .. profiles.default .. " -u excalidraw.com",
}

--------------------------------------------------------------------------------
-- 4. Autostart
--------------------------------------------------------------------------------
hl.on("hyprland.start", function()
	local autostart = {
		-- Background daemons / UI
		{ cmd = launchers.wall },
		{ cmd = launchers.idledaemon },
		{ cmd = launchers.nightlight },
		{ cmd = launchers.panel },
		-- Applications bound to workspaces
		{ cmd = launchers.editor, ws = ws_by_name.vim },
		{ cmd = launchers.terminal, ws = ws_by_name.bash },
		{ cmd = launchers.godocs, ws = ws_by_name.docs },
		{ cmd = launchers.antigravity, ws = ws_by_name.ai },
		{ cmd = launchers.cloud, ws = ws_by_name.cloud },
		{ cmd = launchers.cloud_argolis, ws = ws_by_name.cloud },
		{ cmd = launchers.browser, ws = ws_by_name.web },
		{ cmd = launchers.mail, ws = ws_by_name.mail },
		{ cmd = launchers.calendar, ws = ws_by_name.calendar },
		{ cmd = launchers.meet, ws = ws_by_name.gvc },
		{ cmd = launchers.browser_personal, ws = ws_by_name.personal },
	}

	for _, item in ipairs(autostart) do
		if item.ws then
			hl.exec_cmd(item.cmd, { workspace = item.ws .. " silent" })
		else
			hl.exec_cmd(item.cmd)
		end
	end
end)

--------------------------------------------------------------------------------
-- 5. Keybindings
--------------------------------------------------------------------------------
local keybinds = {
	-- Application Launchers
	{ combo = "SUPER + Escape", action = hl.dsp.exec_cmd(launchers.screenlock) },
	{ combo = "SUPER + Return", action = hl.dsp.exec_cmd(launchers.terminal) },
	{ combo = "SUPER + E", action = hl.dsp.exec_cmd(launchers.filemanager) },
	{ combo = "SUPER + R", action = hl.dsp.exec_cmd(launchers.menu) },
	{ combo = "SUPER + Backspace", action = hl.dsp.exec_cmd(launchers.corne) },
	{ combo = "SUPER + Comma", action = hl.dsp.exec_cmd(launchers.screenshot_clip) },
	{ combo = "SUPER + SHIFT + Comma", action = hl.dsp.exec_cmd(launchers.screenshot_file) },
	{ combo = "SUPER + Period", action = hl.dsp.exec_cmd(launchers.switch_main) },
	{ combo = "SUPER + SHIFT + Period", action = hl.dsp.exec_cmd(launchers.switch_external) },
	{ combo = "SUPER + ALT + M", action = hl.dsp.exec_cmd(launchers.mail_new) },
	{ combo = "SUPER + ALT + X", action = hl.dsp.exec_cmd(launchers.excalidraw) },
	{ combo = "SUPER + ALT + G", action = hl.dsp.exec_cmd(launchers.imageeditor) },
	{ combo = "SUPER + ALT + B", action = hl.dsp.exec_cmd(launchers.daw) },
	{ combo = "SUPER + ALT + P", action = hl.dsp.exec_cmd(launchers.colorpicker) },

	-- Layout & Window Control
	{ combo = "SUPER + F", action = hl.dsp.window.fullscreen() },
	{ combo = "SUPER + SHIFT + F", action = hl.dsp.window.float() },
	{ combo = "SUPER + T", action = hl.dsp.layout("togglesplit") },
	{ combo = "SUPER + SHIFT + T", action = hl.dsp.layout("pseudo") },
	{ combo = "SUPER + SHIFT + Q", action = hl.dsp.window.close() },
	{ combo = "SUPER + SHIFT + R", action = hl.dsp.exec_cmd(launchers.reload) },
	{ combo = "SUPER + SHIFT + Escape", action = hl.dsp.exit() },

	-- Focus Navigation
	{ combo = "SUPER + L", action = hl.dsp.focus({ direction = "right" }) },
	{ combo = "SUPER + H", action = hl.dsp.focus({ direction = "left" }) },
	{ combo = "SUPER + K", action = hl.dsp.focus({ direction = "up" }) },
	{ combo = "SUPER + J", action = hl.dsp.focus({ direction = "down" }) },
	{ combo = "SUPER + Tab", action = hl.dsp.focus({ monitor = "+1" }) },

	-- Window Movement
	{ combo = "SUPER + SHIFT + L", action = hl.dsp.window.move({ direction = "right" }) },
	{ combo = "SUPER + SHIFT + H", action = hl.dsp.window.move({ direction = "left" }) },
	{ combo = "SUPER + SHIFT + K", action = hl.dsp.window.move({ direction = "up" }) },
	{ combo = "SUPER + SHIFT + J", action = hl.dsp.window.move({ direction = "down" }) },
	{ combo = "SUPER + SHIFT + Tab", action = hl.dsp.window.move({ monitor = "+1" }) },

	-- Mouse Bindings
	{ combo = "SUPER + mouse:272", action = hl.dsp.window.drag(), opts = { mouse = true } },
	{ combo = "SUPER + mouse:273", action = hl.dsp.window.resize(), opts = { mouse = true } },
}

for _, b in ipairs(keybinds) do
	hl.bind(b.combo, b.action, b.opts)
end

-- Custom floating + pin bind
hl.bind("SUPER + Space", function()
	hl.dispatch(hl.dsp.togglefloating())
	hl.dispatch(hl.dsp.pin())
end)

--------------------------------------------------------------------------------
-- 6. Hardware / Media Controls
--------------------------------------------------------------------------------
local controls = {
	media = {
		play = "playerctl play-pause",
		pause = "playerctl play-pause",
		next = "playerctl next",
		previous = "playerctl previous",
	},
	audio = {
		up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+",
		down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-",
		zero = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%",
		mute = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle && wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
	},
	brightness = {
		up = "brightnessctl -e4 -n2 set 5%+",
		down = "brightnessctl -e4 -n2 set 5%-",
	},
}

local media_binds = {
	{ combo = "XF86AudioRaiseVolume", cmd = controls.audio.up, opts = { locked = true, repeating = true } },
	{ combo = "XF86AudioLowerVolume", cmd = controls.audio.down, opts = { locked = true, repeating = true } },
	{ combo = "XF86AudioMute", cmd = controls.audio.zero, opts = { locked = true, repeating = true } },
	{ combo = "XF86AudioMicMute", cmd = controls.audio.mute, opts = { locked = true, repeating = true } },
	{ combo = "XF86MonBrightnessUp", cmd = controls.brightness.up, opts = { locked = true, repeating = true } },
	{ combo = "XF86MonBrightnessDown", cmd = controls.brightness.down, opts = { locked = true, repeating = true } },
	{ combo = "XF86AudioNext", cmd = controls.media.next, opts = { locked = true } },
	{ combo = "XF86AudioPause", cmd = controls.media.pause, opts = { locked = true } },
	{ combo = "XF86AudioPlay", cmd = controls.media.play, opts = { locked = true } },
	{ combo = "XF86AudioPrev", cmd = controls.media.previous, opts = { locked = true } },
}

for _, b in ipairs(media_binds) do
	hl.bind(b.combo, hl.dsp.exec_cmd(b.cmd), b.opts)
end

--------------------------------------------------------------------------------
-- 7. Zoom Control Helper
--------------------------------------------------------------------------------
local function adjust_zoom(delta)
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	hl.config({ cursor = { zoom_factor = math.max(1.0, current + delta) } })
end

hl.bind("SUPER + SHIFT + I", function()
	adjust_zoom(0.5)
end)
hl.bind("SUPER + SHIFT + O", function()
	adjust_zoom(-0.5)
end)
hl.bind("SUPER + mouse:276", function()
	adjust_zoom(0.5)
end)
hl.bind("SUPER + mouse:275", function()
	adjust_zoom(-0.5)
end)

-- Touchpad Gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

--------------------------------------------------------------------------------
-- 8. Window Rules
--------------------------------------------------------------------------------
local window_rules = {
	-- Application Workspaces
	{ match = { class = "chrome-pkg.go.dev__-Profile.*" }, workspace = ws_by_name.docs .. " silent" },
	{ match = { class = "chrome-console.cloud.google.com__-Profile.*" }, workspace = ws_by_name.cloud .. " silent" },
	{ match = { class = "chrome-excalidraw.com__-Profile.*" }, workspace = ws_by_name.external .. " silent" },
	{ match = { class = "chrome-app.slack.com__client_-Profile.*" }, workspace = ws_by_name.external .. " silent" },
	{ match = { class = "gimp" }, workspace = ws_by_name.external .. " silent" },
	{ match = { class = "chrome-mail.google.com__-Profile.*" }, workspace = ws_by_name.mail .. " silent" },
	{ match = { class = "chrome-calendar.google.com__-Profile.*" }, workspace = ws_by_name.calendar .. " silent" },
	{ match = { class = "chrome-go__nucleus_sparkplug-Profile.*" }, workspace = ws_by_name.notes .. " silent" },
	{ match = { class = "chrome-go__companion-Profile.*" }, workspace = ws_by_name.gvc .. " silent" },
	{ match = { class = "chrome-meet.google.com__-Profile.*" }, workspace = ws_by_name.gvc .. " silent" },
	{ match = { initial_title = "editor" }, workspace = ws_by_name.vim .. " silent" },
	{ match = { initial_title = "antigravity" }, workspace = ws_by_name.ai .. " silent" },

	-- Window Behavior & Overrides
	{ match = { class = "mpv" }, opacity = "1.0 override" },
	{ match = { initial_title = "corne" }, float = true, center = true, size = { 810, 500 } },

	-- Screen Sharing Overlay Rules
	{ match = { initial_title = "meet.google.com is sharing your screen." }, workspace = "special silent" },
	{ match = { initial_title = "zoom.us is sharing your screen." }, workspace = "special silent" },
	{ match = { initial_title = "teams.microsoft.com is sharing your screen." }, workspace = "special silent" },
}

for _, rule in ipairs(window_rules) do
	hl.window_rule(rule)
end

--------------------------------------------------------------------------------
-- 9. General Settings
--------------------------------------------------------------------------------
hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		repeat_rate = 25,
		repeat_delay = 220,
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},
	cursor = {
		inactive_timeout = 1,
		hide_on_key_press = true,
	},
	general = {
		gaps_in = 5,
		gaps_out = 5,
		float_gaps = 5,
		no_focus_fallback = true,
		border_size = 1,
		layout = "dwindle",
		snap = {
			enabled = true,
			respect_gaps = true,
		},
	},
	dwindle = {
		preserve_split = true,
	},
	master = {
		new_status = "master",
	},
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		font_family = "JetBrains Mono Nerd Font",
		focus_on_activate = true,
		disable_hyprland_guiutils_check = true,
	},
	decoration = {
		rounding = 1,
		rounding_power = 2,
		active_opacity = 0.98,
		inactive_opacity = 0.9,
		fullscreen_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},
})

--------------------------------------------------------------------------------
-- 10. Animations & Curves
--------------------------------------------------------------------------------
local curves = {
	{ name = "md3_standard", points = { { 0.2, 0 }, { 0, 1 } } },
	{ name = "md3_decel", points = { { 0, 0 }, { 0.2, 1 } } },
	{ name = "md3_accel", points = { { 0.3, 0 }, { 0.8, 0.15 } } },
	{ name = "overshot", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } },
	{ name = "snappy", points = { { 0.1, 1 }, { 0, 1 } } },
	{ name = "bounce", points = { { 1, 1 }, { 0, 1 } } },
	{ name = "fluid", points = { { 0.22, 1 }, { 0.36, 1 } } },
}

for _, c in ipairs(curves) do
	hl.curve(c.name, { type = "bezier", points = c.points })
end

local animations = {
	{ leaf = "windows", enabled = true, speed = 7, bezier = "overshot", style = "slide" },
	{ leaf = "windowsIn", enabled = true, speed = 5, bezier = "md3_decel", style = "slide top" },
	{ leaf = "windowsOut", enabled = true, speed = 5, bezier = "md3_accel", style = "slide top" },
	{ leaf = "windowsMove", enabled = true, speed = 5, bezier = "overshot", style = "slide" },
	{ leaf = "border", enabled = true, speed = 10, bezier = "md3_standard" },
	{ leaf = "borderangle", enabled = true, speed = 100, bezier = "md3_standard", style = "loop" },
	{ leaf = "fade", enabled = true, speed = 7, bezier = "md3_standard" },
	{ leaf = "fadeIn", enabled = true, speed = 3, bezier = "md3_decel" },
	{ leaf = "fadeOut", enabled = true, speed = 7, bezier = "md3_accel" },
	{ leaf = "layers", enabled = true, speed = 4, bezier = "md3_decel", style = "fade" },
	{ leaf = "layersIn", enabled = true, speed = 3, bezier = "md3_decel", style = "slide top" },
	{ leaf = "layersOut", enabled = true, speed = 3, bezier = "md3_accel", style = "slide top" },
	{ leaf = "workspaces", enabled = true, speed = 7, bezier = "overshot", style = "slidefade 20%" },
	{ leaf = "workspacesIn", enabled = true, speed = 7, bezier = "overshot", style = "slidefade 20%" },
	{ leaf = "workspacesOut", enabled = true, speed = 7, bezier = "overshot", style = "slidefade 20%" },
	{ leaf = "specialWorkspace", enabled = true, speed = 7, bezier = "overshot", style = "slidevert" },
	{ leaf = "zoomFactor", enabled = true, speed = 5, bezier = "fluid" },
}

for _, anim in ipairs(animations) do
	hl.animation(anim)
end

--------------------------------------------------------------------------------
-- 11. Environment & Theme
--------------------------------------------------------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Source active theme
dofile(os.getenv("HOME") .. "/.themes/default/hyprland.lua")
