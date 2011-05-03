import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect

myLayout = smartBorders (Full ||| tiled ||| Mirror tiled ||| reflectHoriz tiled ||| reflectVert (Mirror tiled))
 where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 3/4
    delta = 3/100

main = do
  xmonad $ defaultConfig
    { terminal    = "urxvt"
    , modMask     = mod1Mask
    , borderWidth = 1
    , layoutHook = myLayout
    }
