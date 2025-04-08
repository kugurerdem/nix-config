{pkgs, ...}: {
  home.packages = with pkgs; [
    vlc # General media player
    mpv # General media player
    stremio # Watch movies/tv-series
    sxiv # image viewer
    kdePackages.okular # PDF Reader
  ];
}
