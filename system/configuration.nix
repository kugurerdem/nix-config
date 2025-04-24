{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix  # Include the results of the hardware scan.
    ./users.nix
    ./bluetooth.nix
    ./gnome.nix
    ./ld.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  swapDevices = [
    { device = "/swapfile"; }
  ];

  # Set networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    autorun = false;

    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;

    displayManager.session = [
        {
            manage = "window";
            name = "dwm";
            # if the user has dwm installed, use it
            start = ''
                dwm &
                waitPID=$!
            '';
        }
    ];

    displayManager.defaultSession = "none+dwm";

    xkb.layout = "us";
    xkb.variant = "";
  };

  services.udisks2.enable = true;

  virtualisation.docker.enable = true;

  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
  };

  programs.light.enable = true;

  services.flatpak.enable = true;
  # required for flatpak
  xdg.portal = with pkgs; {
    enable = true;
    extraPortals = [ xdg-desktop-portal-gtk ];
    configPackages = [ xdg-desktop-portal-gtk ];
  };

  programs.fish.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    home-manager
    vim
    git
  ];

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
    PAGER = "less";
  };

  environment.localBinInPath = true;

  nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
  };

  system.stateVersion = "24.05";
}
