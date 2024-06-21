[ -f ~/.xprofile ] && . ~/.xprofile

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

dwmblocks &
dunst &
picom &
wallpaper-manager &

keyboard &

exec dwm
