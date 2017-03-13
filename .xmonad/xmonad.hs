import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)
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
    , focusedBorderColor = "#ffffff"
    }
