-- Monitors
local layout = "home-big"

local layouts = {
	["office"] = {
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

local selected = layouts[layout] or {
	{ output = "", mode = "preferred", position = "auto", scale = "auto" },
}

for _, layout_cfg in ipairs(selected) do
	hl.monitor(layout_cfg)
end

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
	editor = "foot -T editor bash 'source .bashrc && nvim && bash'",
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

-- Workspaces
local spaces = {
	bash = { number = 1, key = "B", icon = "" },
	vim = { number = 2, key = "V", icon = "" },
	docs = { number = 3, key = "D", icon = "󱔗" },
	cloud = { number = 4, key = "G", icon = "" },
	ai = { number = 5, key = "A", icon = "" },
	web = { number = 6, key = "W", icon = "" },
	mail = { number = 7, key = "M", icon = "" },
	calendar = { number = 8, key = "C", icon = "" },
	notes = { number = 9, key = "N", icon = "" },
	gvc = { number = 10, key = "Z", icon = "" },
	personal = { number = 11, key = "P", icon = "" },
	external = { number = 12, key = "X", icon = "󰍺" },
}
for _, item in pairs(spaces) do
	local ws, key = item.number, item.key
	hl.bind("ALT + " .. key, hl.dsp.focus({ workspace = ws }))
	hl.bind("ALT + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
end

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd(launchers.wall)
	hl.exec_cmd(launchers.idledaemon)
	hl.exec_cmd(launchers.nightlight)
	hl.exec_cmd(launchers.panel)
	hl.exec_cmd(launchers.editor, { workspace = spaces.vim.number .. " silent" })
	hl.exec_cmd(launchers.terminal, { workspace = spaces.bash.number .. " silent" })
	hl.exec_cmd(launchers.godocs, { workspace = spaces.docs.number .. " silent" })
	hl.exec_cmd(launchers.antigravity, { workspace = spaces.ai.number .. " silent" })
	hl.exec_cmd(launchers.cloud, { workspace = spaces.cloud.number .. " silent" })
	hl.exec_cmd(launchers.cloud_argolis, { workspace = spaces.cloud.number .. " silent" })
	hl.exec_cmd(launchers.browser, { workspace = spaces.web.number .. " silent" })
	hl.exec_cmd(launchers.mail, { workspace = spaces.mail.number .. " silent" })
	hl.exec_cmd(launchers.calendar, { workspace = spaces.calendar.number .. " silent" })
	hl.exec_cmd(launchers.meet, { workspace = spaces.gvc.number .. " silent" })
	hl.exec_cmd(launchers.browser_personal, { workspace = spaces.personal.number .. " silent" })
end)

-- Launchers
hl.bind("ALT + Escape", hl.dsp.exec_cmd(launchers.screenlock))
hl.bind("ALT + Return", hl.dsp.exec_cmd(launchers.terminal))
hl.bind("ALT + E", hl.dsp.exec_cmd(launchers.filemanager))
hl.bind("ALT + R", hl.dsp.exec_cmd(launchers.menu))
hl.bind("ALT + Backspace", hl.dsp.exec_cmd(launchers.corne))
hl.bind("ALT + Comma", hl.dsp.exec_cmd(launchers.screenshot_clip))
hl.bind("ALT + SHIFT + Comma", hl.dsp.exec_cmd(launchers.screenshot_file))
hl.bind("ALT + Period", hl.dsp.exec_cmd(launchers.switch_main))
hl.bind("ALT + SHIFT + Period", hl.dsp.exec_cmd(launchers.switch_external))
hl.bind("ALT + SUPER + M", hl.dsp.exec_cmd(launchers.mail_new))
hl.bind("ALT + SUPER + X", hl.dsp.exec_cmd(launchers.excalidraw))
hl.bind("ALT + SUPER + G", hl.dsp.exec_cmd(launchers.imageeditor))
hl.bind("ALT + SUPER + B", hl.dsp.exec_cmd(launchers.daw))
hl.bind("ALT + SUPER + P", hl.dsp.exec_cmd(launchers.colorpicker))

-- Controls
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

-- Controls: Media, Audio, Brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(controls.audio.up), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(controls.audio.down), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(controls.audio.zero), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(controls.audio.mute), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(controls.brightness.up), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(controls.brightness.down), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(controls.media.next), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(controls.media.pause), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(controls.media.play), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(controls.media.previous), { locked = true })

-- Controls: Layout
hl.bind("ALT + F", hl.dsp.window.fullscreen())
hl.bind("ALT + SHIFT + F", hl.dsp.window.float())
hl.bind("ALT + T", hl.dsp.layout("togglesplit"))
hl.bind("ALT + SHIFT + T", hl.dsp.layout("pseudo"))
hl.bind("ALT + SHIFT + Q", hl.dsp.window.close())
hl.bind("ALT + SHIFT + R", hl.dsp.exec_cmd(launchers.reload))
hl.bind("ALT + SHIFT + Escape", hl.dsp.exit())
hl.bind("ALT + Space", function()
	hl.dispatch(hl.dsp.togglefloating())
	hl.dispatch(hl.dsp.pin())
end)

-- Controls: Zoom
hl.bind("ALT + SHIFT + I", function()
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	hl.config({ cursor = { zoom_factor = current + 0.5 } })
end)
hl.bind("ALT + SHIFT + O", function()
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	hl.config({ cursor = { zoom_factor = math.max(1.0, current - 0.5) } })
end)
hl.bind("ALT + mouse:276", function()
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	hl.config({ cursor = { zoom_factor = current + 0.5 } })
end)
hl.bind("ALT + mouse:275", function()
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	hl.config({ cursor = { zoom_factor = math.max(1.0, current - 0.5) } })
end)

-- Controls: Move focus
hl.bind("ALT + L", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + H", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + K", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + J", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab", hl.dsp.focus({ monitor = "+1" }))
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Controls: Move window
hl.bind("ALT + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("ALT + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("ALT + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("ALT + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.move({ monitor = "+1" }))
hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Window Rules
hl.window_rule({
	match = { class = "chrome-pkg.go.dev__-Profile.*" },
	workspace = spaces.docs.number .. " silent",
})
hl.window_rule({
	match = { class = "chrome-console.cloud.google.com__-Profile.*" },
	workspace = spaces.cloud.number .. " silent",
})
hl.window_rule({
	match = { class = "chrome-excalidraw.com__-Profile.*" },
	workspace = spaces.external.number .. " silent",
})
hl.window_rule({
	match = { class = "chrome-app.slack.com__client_-Profile.*" },
	workspace = spaces.external.number .. " silent",
})
hl.window_rule({
	match = { class = "gimp" },
	workspace = spaces.external.number .. " silent",
})
hl.window_rule({
	match = { class = "chrome-mail.google.com__-Profile.*" },
	workspace = spaces.mail.number .. " silent",
})
hl.window_rule({
	match = { class = "chrome-calendar.google.com__-Profile.*" },
	workspace = spaces.calendar.number .. " silent",
})
hl.window_rule({
	match = { class = "chrome-go__nucleus_sparkplug-Profile.*" },
	workspace = spaces.notes.number .. " silent",
})
hl.window_rule({
	match = { class = "chrome-go__companion-Profile.*" },
	workspace = spaces.gvc.number .. " silent",
})
hl.window_rule({
	match = { class = "chrome-meet.google.com__-Profile.*" },
	workspace = spaces.gvc.number .. " silent",
})
hl.window_rule({
	match = { initial_title = "editor" },
	workspace = spaces.vim.number .. " silent",
})
hl.window_rule({
	match = { initial_title = "antigravity" },
	workspace = spaces.ai.number .. " silent",
})
hl.window_rule({
	match = { class = "mpv" },
	opacity = "1.0 override",
})
hl.window_rule({
	match = { initial_title = "corne" },
	float = true,
	center = true,
	size = { 810, 500 },
})
hl.window_rule({
	match = { initial_title = "meet.google.com is sharing your screen." },
	workspace = "special silent",
})
hl.window_rule({
	match = { initial_title = "zoom.us is sharing your screen." },
	workspace = "special silent",
})
hl.window_rule({
	match = { initial_title = "teams.microsoft.com is sharing your screen." },
	workspace = "special silent",
})

-- General configuration
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

-- Animations
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0, 0 }, { 0.2, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("snappy", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("bounce", { type = "bezier", points = { { 1, 1 }, { 0, 1 } } })
hl.curve("fluid", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } })
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, bezier = "md3_decel", style = "slide top" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "md3_accel", style = "slide top" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "md3_standard" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "md3_standard", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "md3_standard" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 7, bezier = "md3_accel" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "md3_decel", style = "fade" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "md3_decel", style = "slide top" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "md3_accel", style = "slide top" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "overshot", style = "slidefade 20%" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 7, bezier = "overshot", style = "slidefade 20%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 7, bezier = "overshot", style = "slidefade 20%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 7, bezier = "overshot", style = "slidevert" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 5, bezier = "fluid" })

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

dofile(os.getenv("HOME") .. "/.themes/default/hyprland.lua")
