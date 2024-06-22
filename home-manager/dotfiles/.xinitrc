[ -f ~/.xprofile ] && . ~/.xprofile

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

exec dwm
