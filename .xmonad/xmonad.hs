import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO

main = do
  xmproc <- spawnPipe "feh --bg-scale ~/Pictures/Wallpapers/Alejandra/_MG_6088.jpg &"
  xmproc <- spawnPipe "xmobar"
  xmproc <- spawnPipe "urxvtd"
  xmonad $ defaultConfig
    { modMask = mod4Mask
    , manageHook = manageDocks <+> manageHook defaultConfig
    , layoutHook = avoidStruts $ layoutHook defaultConfig
    , handleEventHook = mconcat
          [ docksEventHook
          , handleEventHook defaultConfig ]
    , terminal = "urxvtc"
    , borderWidth = 2
    , normalBorderColor = "#404040"
    , focusedBorderColor = "#d4dee9"
    }
      `additionalKeys`
          [ ((mod4Mask, xK_r ), spawn "dmenu_run -nb '#030405' -nf '#e46c8b' -fn 'terminus-9'")
	]
