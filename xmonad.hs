import XMonad
import XMonad.Layout.Reflect
import Control.Monad
import Control.Monad.Instances
import Data.Maybe
import Data.List
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Hooks.FadeInactive
import XMonad.Actions.UpdatePointer
import XMonad.Util.NamedWindows
import XMonad.Actions.CycleWS
import Data.Monoid
import XMonad.Hooks.ManageHelpers
import XMonad.Util.WorkspaceCompare

myLayout = avoidStruts (tiled ||| Mirror tiled ||| Full)
 where
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 2/3
    delta = 3/100

main = do
  h <- spawnPipe ("~/bin/xmui")
  xmonad myConfig {logHook = fadeHook 0.95 0.8
                              >> updatePointer (Relative 0.95 0.95)
                              >> dynamicLogWithPP (myPP h)}

fadeHook ::Rational ->Rational ->X ()
fadeHook active inactive = fadeOutLogHook $ do
                                u <- isUnfocused
                                term <- className =?"URxvt" <||> className =?"dzen"
                                fs <- isFullscreen
                                return $ if fs then 1
                                          else if u /=term then inactive
                                          else active

myPP h = dzenPP
         { ppOutput = hPutStrLn h
         , ppHidden = clickable $ dzenColor "#666666" "#aaaaaa" . pad
         , ppCurrent = dzenColor "white" "#1a1a1a" . pad
         , ppLayout = wrap "^ca(1,xdotool key alt+space)" "^ca()" .
                      dzenColor "black" "#aaaaaa" .
                      layoutIcon "#666666" "#aaaaaa"
         , ppTitle  = wrap "^ca(1,xdotool key alt+Tab)" "^ca()" .
                      dzenColor "black" "#aaaaaa" . ( ++ " ") .
                      dzenEscape
         , ppExtras = [inactiveWindows]
         }
  where clickable f i =
         wrap ("^ca(1,xdotool key alt+" ++ i ++ ")") "^ca()" $ f i

layoutIcon fg bg x =
  case x of
    "Tall" -> "B^r(6x17)F^r(1x13)B^r(3x17)F^r(1x13)B^r(6x17)" >>= colors
    --"Tall" -> "B^r(8x17)F^r(1x13)B^r(8x17)" >>= colors -- single bar
    "Mirror Tall" -> "B^r(2x17)F^r(13x1)B^r(2x17)" >>= colors
    "Full" -> "B^r(3x17)F^ro(11x11)B^r(3x17)" >>= colors
    _ -> dzenColor fg bg . pad $ x
   where colors c = case c of
                      'F' -> "^fg(" ++ fg ++ ")"
                      'B' -> "^fg(" ++ bg ++ ")"
                      _   -> [c]

inactiveWindows = withWindowSet $ liftM (format . map show)
                              . mapM getName
                              . concat
                              . sequence (map (maybe []) [W.up, W.down])
                              . W.stack . W.workspace . W.current
   where format l = guard (not (null l)) >> return
                     (wrap "^fg(#666666)  [[" "]]^fg()"
                      . intercalate " || "
                      $ l )

isCurrentWSEmpty = withWindowSet (return . isNothing . W.stack . W.workspace . W.current)

-- switch to previous active workspace when current one is empty
myEventHook DestroyWindowEvent {} = do
   empty <- isCurrentWSEmpty
   when empty (doTo Next NonEmptyWS (return tail) (windows . W.greedyView))
   stillEmpty <- isCurrentWSEmpty -- all workspaces empty; switch to first one
   when stillEmpty $ do
      byIndex <- getSortByIndex
      withWindowSet (windows . W.greedyView . W.tag . head . byIndex . W.workspaces)
   return (All True)

myEventHook _ = return (All True)

myManageHook = isFullscreen --> (doFullFloat <+> doShiftEmpty)

doShiftEmpty = ask >>= \w -> liftX $ do
   i <- findWorkspace getSortByIndex Next EmptyWS 1
   return (Endo (W.greedyView i) <+> Endo (W.shiftWin i w))

myConfig = defaultConfig
           { terminal    = "urxvtc"
           , modMask     = mod1Mask
           , borderWidth = 0
           , focusedBorderColor = "blue"
           , layoutHook  = myLayout
           , manageHook  = myManageHook <+> manageDocks <+> manageHook defaultConfig
           , startupHook = refresh
           , handleEventHook = myEventHook
           } `additionalKeysP` myKeyBindings

myKeyBindings =
  [ ("M-S-k", spawn "xkill" )
  , ("M-S-h", spawn "setxkbmap -layout il")
  , ("M-S-.", spawn "bash ~/.kb")
  , ("M-p"  , spawn "dmenu_run")
  , ("M-S-m", spawn "~/scripts/playflash.sh")
  , ("M-S-l", spawn "ps -u mendel -o comm | sort | uniq | dmenu | xargs pkill -n")
  , ("M-S-x", spawn "ps -u mendel -o comm | sort | uniq | dmenu | xargs pkill -n -9") 
  , ("M-q",   spawn "killall dzen2; xmonad --recompile && xmonad --restart")
  , ("M-<Backspace>", sendMessage ToggleStruts)
  , ("M-S-\\", isCurrentWSEmpty >>= (when . not) `flip` moveTo Next EmptyWS
                >> asks (terminal . config) >>= spawn)
  ]
