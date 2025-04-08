{pkgs, ...}: {
  home.packages = with pkgs; [
    xfce.thunar # file manager
    xfce.tumbler
    blueberry # bluetooth manager GUI
    pavucontrol
  ];
}
