xrdb -merge ~/.Xresources
xmodmap .xmodmaprc
#xsetroot -cursor_name left_ptr
urxvtd -f -o -q
urxvt &
unclutter -idle 3 -jitter 20 &
exec xmonad
