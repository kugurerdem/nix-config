{ config, pkgs, ... }: {
  imports = [
    /etc/nixos/hardware-configuration.nix

    ./modules/neovim.nix

    ./modules/selfhost/freshrss.nix
    ./modules/selfhost/readeck.nix
    ./modules/selfhost/syncthing.nix
    ./modules/selfhost/nextcloud.nix

    ./modules/selfhost/ssl-nginx.nix
  ];

  # TODO: maybe put these in a more uniform form
  services.freshrss.baseUrl = "rss.local";
  services.readeck.settings.server.base_url = "readeck.local";
  services.syncthing.guiDomain = "syncthing.local";
  services.nextcloud.hostName = "nextcloud.local";

  # TODO: maybe DRY
  networking.extraHosts = ''
  127.0.0.1 freshrss.local
  127.0.0.1 readeck.local
  127.0.0.1 syncthing.local
  127.0.0.1 nextcloud.local
  '';

  services.nginx = {
    enable = true;
    defaultHTTPListenPort = 80;
  };

  DomainstToCertifyForNginx = {
    enable = false;
    useACME = true;
    # You can also use custom certificates, if you want. But be sure to set
    # useACME to false if you decide to do it that way.
    # sslCertificate = /etc/ssl/mycert.pem;
    # sslCertificateKey = /etc/ssl/private/mycert-key.pem;
    domains = [ "freshrss.local" "readeck.local" "syncthing.local" "nextcloud.local" ];
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };

    enable = true;
    autorun = false;

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  }; 

  users.users.selfhost = {
    isNormalUser = true;
    description = "selfhost";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

	security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    firefox
    git
  ];

  system.stateVersion = "24.11";
}
