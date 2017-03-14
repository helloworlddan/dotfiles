import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO

baseConfig = desktopConfig

main = do
  xmproc <- spawnPipe "urxvtd"
  xmproc <- spawnPipe "xmobar"
  xmproc <- spawnPipe "VBoxClient-all"
  xmonad $ baseConfig
    { terminal = "urxvtc"
    , borderWidth = 2
    , normalBorderColor = "#404040"
    , focusedBorderColor = "#d4dee9"
    }
	`additionalKeys`
		[ ((mod1Mask, xK_r ), spawn "dmenu_run -nb '#030405' -nf '#e46c8b' - ")
	]
