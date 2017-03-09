import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)
import System.IO

baseConfig = desktopConfig

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ baseConfig
    { terminal = "xfce4-terminal"
    , borderWidth = 2
    , normalBorderColor = "#404040"
    , focusedBorderColor = "#ffffff"
    }
