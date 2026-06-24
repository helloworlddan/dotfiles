local display_profile = "home-big"

if display_profile == "office" then
	hl.monitor({
		output = "eDP-1",
		mode = "1920x1200@60",
		position = "3840x0",
		scale = 1,
	})
	hl.monitor({
		output = "DP-1",
		mode = "3840x2160@60",
		position = "0x0",
		scale = 1.0666,
	})
elseif display_profile == "home-big" then
	hl.monitor({
		output = "eDP-1",
		mode = "1920x1200@60",
		position = "0x1440",
		scale = 1,
	})
	hl.monitor({
		output = "DP-1",
		mode = "2560x1440@60",
		position = "0x0",
		scale = 1,
	})
elseif display_profile == "home-small" then
	hl.monitor({
		output = "eDP-1",
		mode = "1920x1200@60",
		position = "1920x0",
		scale = 1,
	})
	hl.monitor({
		output = "DP-1",
		mode = "1920x1080@60",
		position = "0x0",
		scale = 1,
	})
elseif display_profile == "dual-mirror" then
	hl.monitor({
		output = "eDP-1",
		mode = "1920x1080@60",
		position = "0x0",
		scale = 1,
	})
	hl.monitor({
		output = "DP-1",
		mode = "1920x1080@60",
		mirror = "eDP-1",
		position = "0x0",
		scale = 1,
	})
	hl.monitor({
		output = "HDMI-A-1",
		mode = "1920x1080@60",
		mirror = "eDP-1",
		position = "0x0",
		scale = 1,
	})
else
	hl.monitor({
		output = "",
		mode = "preferred",
		position = "auto",
		scale = "auto",
	})
end

-- Workspaces Variables
local ws_bsh = 1
local ws_vim = 2
local ws_doc = 3
local ws_gcp = 4
local ws_ai = 5
local ws_web = 6
local ws_mail = 7
local ws_cal = 8
local ws_not = 9
local ws_gvc = 10
local ws_pers = 11
local ws_ext = 12

local wsk_bsh = "B"
local wsk_vim = "V"
local wsk_doc = "D"
local wsk_gcp = "G"
local wsk_ai = "A"
local wsk_web = "W"
local wsk_mail = "M"
local wsk_cal = "C"
local wsk_not = "N"
local wsk_gvc = "Z"
local wsk_pers = "P"
local wsk_ext = "X"

-- Chrome Profiles
local cp = 1
local cp_argolis = 2
local cp_personal = 3

-- Launchers
local hypr_reload = "hyprctl reload"
local wall = "hyprpaper"
local panel = "waybar"
local terminal = "foot"
local editor = "foot -T editor bash 'source .bashrc && nvim && bash'"
local antigravity = "foot -T antigravity bash -c 'source .bashrc && agy && bash'"
local filemanager = "foot -T filemanager ranger"
local corne = "foot -T corne -H cat Code/github.com/helloworlddan/corne/layout.txt"
local switch_main = "foot bash -c 'source .bashrc && hswitchscreen'"
local switch_external = "foot bash -c 'source .bashrc && hswitchscreen DP-1'"
local screenlock = "hyprlock"
local idledaemon = "hypridle"
local menu = "wofi"
local imageeditor = "gimp"
local colorpicker = "hyprpicker"
local nightlight = "gammastep -p wayland -l 53:10"
local daw = "bitwig-studio"
local screenshot_file = "grim -g \"$(slurp)\" ~/shot-$(date +'%s').png"
local screenshot_clip = 'grim -g "$(slurp)" - | wl-copy'
local browser = "goto -p " .. cp
local browser_argolis = "goto -p " .. cp_argolis
local browser_personal = "goto -p " .. cp_personal
local mail = "goto -p " .. cp .. " -g mail"
local mail_new = "goto -p " .. cp .. " -u mail.google.com/mail/?view=cm&fs=1&tf=1"
local calendar = "goto -p " .. cp .. " -g calendar"
local meet = "goto -p " .. cp .. " -g meet"
local cloud = "goto -p " .. cp .. " -g console.cloud"
local cloud_argolis = "goto -p " .. cp_argolis .. " -g console.cloud"
local cloud_personal = "goto -p " .. cp_personal .. " -g console.cloud"
local godocs = "goto -p " .. cp .. " -u pkg.go.dev"
local sparkplug = "goto -p " .. cp .. " nucleus:sparkplug"
local excalidraw = "goto -p " .. cp .. " -u excalidraw.com"
local slack = "slack" -- Defined as empty/fallback to avoid nil reference error

-- Window Rules
hl.window_rule({ match = { class = "chrome-pkg.go.dev__-Profile.*" }, workspace = ws_doc .. " silent" })
hl.window_rule({ match = { class = "chrome-console.cloud.google.com__-Profile.*" }, workspace = ws_gcp .. " silent" })
hl.window_rule({ match = { class = "chrome-excalidraw.com__-Profile.*" }, workspace = ws_ext .. " silent" })
hl.window_rule({ match = { class = "chrome-app.slack.com__client_-Profile.*" }, workspace = ws_ext .. " silent" })
hl.window_rule({ match = { class = "gimp" }, workspace = ws_ext .. " silent" })
hl.window_rule({ match = { class = "chrome-mail.google.com__-Profile.*" }, workspace = ws_mail .. " silent" })
hl.window_rule({ match = { class = "chrome-calendar.google.com__-Profile.*" }, workspace = ws_cal .. " silent" })
hl.window_rule({ match = { class = "chrome-go__nucleus_sparkplug-Profile.*" }, workspace = ws_not .. " silent" })
hl.window_rule({ match = { class = "chrome-go__companion-Profile.*" }, workspace = ws_gvc .. " silent" })
hl.window_rule({ match = { class = "chrome-meet.google.com__-Profile.*" }, workspace = ws_gvc .. " silent" })
hl.window_rule({ match = { initial_title = "editor" }, workspace = ws_vim .. " silent" })
hl.window_rule({ match = { initial_title = "antigravity" }, workspace = ws_ai .. " silent" })

hl.window_rule({ match = { class = "mpv" }, opacity = "1.0 override" })
hl.window_rule({ match = { initial_title = "corne" }, float = true, center = true, size = { 810, 470 } })

hl.window_rule({ match = { initial_title = "meet.google.com is sharing your screen." }, workspace = "special silent" })
hl.window_rule({ match = { initial_title = "zoom.us is sharing your screen." }, workspace = "special silent" })
hl.window_rule({
	match = { initial_title = "teams.microsoft.com is sharing your screen." },
	workspace = "special silent",
})

-- Autostart
hl.on("hyprland.start", function()
	hl.exec_cmd(wall)
	hl.exec_cmd(idledaemon)
	hl.exec_cmd(nightlight)
	hl.exec_cmd(panel)
	hl.exec_cmd(editor, { workspace = ws_vim .. " silent" })
	hl.exec_cmd(terminal, { workspace = ws_bsh .. " silent" })
	hl.exec_cmd(godocs, { workspace = ws_doc .. " silent" })
	hl.exec_cmd(antigravity, { workspace = ws_ai .. " silent" })
	hl.exec_cmd(cloud, { workspace = ws_gcp .. " silent" })
	hl.exec_cmd(cloud_argolis, { workspace = ws_gcp .. " silent" })
	hl.exec_cmd(browser, { workspace = ws_web .. " silent" })
	hl.exec_cmd(mail, { workspace = ws_mail .. " silent" })
	hl.exec_cmd(calendar, { workspace = ws_cal .. " silent" })
	hl.exec_cmd(meet, { workspace = ws_gvc .. " silent" })
	hl.exec_cmd(browser_personal, { workspace = ws_pers .. " silent" })
end)

-- Keybindings
local mainMod = "ALT"

-- Basic layout controls
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.layout("pseudo"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(hypr_reload))
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exit())

-- Screen zooming keybinds (Native Lua implementation!)
hl.bind(mainMod .. " + SHIFT + I", function()
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	hl.config({ cursor = { zoom_factor = current + 0.5 } })
end)
hl.bind(mainMod .. " + SHIFT + O", function()
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	hl.config({ cursor = { zoom_factor = math.max(1.0, current - 0.5) } })
end)
hl.bind(mainMod .. " + mouse:276", function()
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	hl.config({ cursor = { zoom_factor = current + 0.5 } })
end)
hl.bind(mainMod .. " + mouse:275", function()
	local current = hl.get_config("cursor.zoom_factor") or 1.0
	hl.config({ cursor = { zoom_factor = math.max(1.0, current - 0.5) } })
end)

-- Launching applications
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd(screenlock))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(filemanager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Backspace", hl.dsp.exec_cmd(corne))
hl.bind(mainMod .. " + Comma", hl.dsp.exec_cmd(screenshot_clip))
hl.bind(mainMod .. " + SHIFT + Comma", hl.dsp.exec_cmd(screenshot_file))
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd(switch_main))
hl.bind(mainMod .. " + SHIFT + Period", hl.dsp.exec_cmd(switch_external))

hl.bind(mainMod .. " + SUPER + M", hl.dsp.exec_cmd(mail_new))
hl.bind(mainMod .. " + SUPER + S", hl.dsp.exec_cmd(slack))
hl.bind(mainMod .. " + SUPER + X", hl.dsp.exec_cmd(excalidraw))
hl.bind(mainMod .. " + SUPER + G", hl.dsp.exec_cmd(imageeditor))
hl.bind(mainMod .. " + SUPER + B", hl.dsp.exec_cmd(daw))
hl.bind(mainMod .. " + SUPER + P", hl.dsp.exec_cmd(colorpicker))

-- Move focus (Vim keys)
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move window (Vim keys)
hl.bind(mainMod .. "+ SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. "+ SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. "+ SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. "+ SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Cycle monitor focus
hl.bind(mainMod .. " + Tab", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " SHIFT + Tab", hl.dsp.window.move({ monitor = "+1" }))

local workspaces = {
	{ key = wsk_bsh, ws = ws_bsh },
	{ key = wsk_vim, ws = ws_vim },
	{ key = wsk_doc, ws = ws_doc },
	{ key = wsk_gcp, ws = ws_gcp },
	{ key = wsk_ai, ws = ws_ai },
	{ key = wsk_web, ws = ws_web },
	{ key = wsk_mail, ws = ws_mail },
	{ key = wsk_cal, ws = ws_cal },
	{ key = wsk_not, ws = ws_not },
	{ key = wsk_gvc, ws = ws_gvc },
	{ key = wsk_pers, ws = ws_pers },
	{ key = wsk_ext, ws = ws_ext },
}

for _, item in ipairs(workspaces) do
	hl.bind(mainMod .. " + " .. item.key, hl.dsp.focus({ workspace = item.ws }))
	hl.bind(mainMod .. " + SHIFT + " .. item.key, hl.dsp.window.move({ workspace = item.ws }))
end

hl.bind(mainMod .. " + Space", function()
	hl.dispatch(hl.dsp.togglefloating())
	hl.dispatch(hl.dsp.pin())
end)
hl.bind(mainMod .. " + SHIFT + Space", function()
	hl.dispatch(hl.dsp.togglefloating())
	hl.dispatch(hl.dsp.pin())
end)

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

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
})

hl.config({
	cursor = {
		inactive_timeout = 1,
		hide_on_key_press = true,
	},
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.config({
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

-- Advanced Animations Curves (Bezier)
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0, 0 }, { 0.2, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("snappy", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("bounce", { type = "bezier", points = { { 1, 1 }, { 0, 1 } } })
hl.curve("fluid", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } })

-- Animations Leaf Mapping
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

-- Environment Variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

dofile(os.getenv("HOME") .. "/.themes/default/hyprland.lua")
