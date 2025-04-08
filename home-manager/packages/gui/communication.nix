{pkgs, ...}: {
  home.packages = with pkgs; [
    telegram-desktop
    signal-desktop
    slack
  ];
}
