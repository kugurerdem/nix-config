{ config, pkgs, ... }:

let
    dwm = pkgs.dwm.overrideAttrs {
        src = fetchGit { url = "https://github.com/kugurerdem/dwm.git"; };
    };

    dwmblocks = pkgs.dwmblocks.overrideAttrs {
        src = fetchGit { url = "https://github.com/kugurerdem/dwmblocks.git"; };
    };
in
{
  home = {
    packages = with pkgs; [
      dwm
      dwmblocks
      dmenu

      scrot # for takin screenshots
      slock # X screen locker
    ];
  };
}
