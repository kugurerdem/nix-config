{ config, pkgs, ... }:

{
  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = (with pkgs; [
      atomix # puzzle game
      cheese # webcam tool
      epiphany # web browser
      evince # document viewer
      geary # email reader
      gedit # text editor
      gnome-calculator
      gnome-characters
      gnome-contacts
      gnome-keyring
      gnome-maps
      gnome-music
      gnome-photos
      gnome-terminal
      gnome-text-editor
      gnome-tour
      gnome-weather
      hitori # sudoku game
      iagno # go game
      simple-scan
      tali # poker game
      totem # video player
      yelp # help viewer
  ]);
}
