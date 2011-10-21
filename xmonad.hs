import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import Control.Monad
import Data.Maybe
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

myLayout = smartBorders (Full ||| tiled ||| Mirror tiled ||| reflectHoriz tiled ||| reflectVert (Mirror tiled))
 where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 3/4
    delta = 3/100

-- myManageHook = title =? "FsKGywg4x5PgquoIf2YJ" --> doF hide
--   where hide s = (fromMaybe id . liftM W.delete . W.peek) s s

main = do
  xmonad $ defaultConfig
    { terminal    = "urxvt"
    , modMask     = mod1Mask
    , borderWidth = 1
    , focusedBorderColor = "blue"
    , layoutHook  = myLayout
    , manageHook  = manageHook defaultConfig
    }
     `additionalKeysP`
    [ ("M-S-k", spawn "xkill" ) ,
      ("M-S-h", spawn "setxkbmap -layout il") ,
      ("M-S-.", spawn "bash ~/.kb") ,
      ("M-p"  , spawn "dmenu_run") ,
      ("M-S-m", spawn "~/scripts/playflash.sh") ,
      ("M-S-l", spawn "ps -u mendel -o comm | sort | uniq | dmenu | xargs pkill -n") ,
      ("M-S-x", spawn "ps -u mendel -o comm | sort | uniq | dmenu | xargs pkill -n -9")
    ]
