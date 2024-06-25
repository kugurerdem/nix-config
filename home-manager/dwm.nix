{ config, pkgs, ... }:

let
    dwm = pkgs.dwm.overrideAttrs {
        src = fetchGit {
            url = "https://github.com/kugurerdem/dwm.git";
        };
    };

    dwmblocks = pkgs.dwmblocks.overrideAttrs {
        src = fetchGit {
            url = "https://github.com/kugurerdem/dwmblocks.git";
        };
    };
in
{
    home = {
        file.".xinitrc".source = ./dotfiles/.xinitrc;
        file.".Xresources".source = ./dotfiles/.Xresources;
        file.".xprofile".source = ./dotfiles/.xprofile;

        packages = with pkgs; [
            dwm
            dwmblocks
            dmenu
            dunst # notification daemon
            libnotify # includes notify-send
            scrot # for takin screenshots
            slock # X screen locker

            # clipboard utils
            xclip
            xsel

            xorg.xkill
        ];
    };
}
