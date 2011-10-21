xrdb -merge ~/.Xresources
. ~/.kb
#xsetroot -cursor_name left_ptr
firefox &
#(sleep 10 && firefox -chrome .hidden.html) &
urxvtd -f -o -q
#urxvt &
unclutter -idle 3 -jitter 20 &
xflux -z 60201 &
exec xmonad
