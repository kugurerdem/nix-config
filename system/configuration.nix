# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set networking
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    autorun = false;

    displayManager.lightdm.enable = true;
    displayManager.startx.enable = false;

    displayManager.session = [
        # add new sessions to try different wms
        {
            manage = "window";
            name = "dwm";
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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
  };

  programs.light.enable = true;

  services.flatpak.enable = true;
  # required for flatpak
  xdg.portal = with pkgs; {
    enable = true;
    extraPortals = [ xdg-desktop-portal-gtk ];
    configPackages = [ xdg-desktop-portal-gtk ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rugu = {
    isNormalUser = true;
    description = "rugu";
    extraGroups = [ "networkmanager" "wheel" "audio" "sound" "video" ];
    packages = with pkgs; [];
  };

  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnfreePredicate = (_: true);

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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

  nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
  };

  system.stateVersion = "24.05";
}
