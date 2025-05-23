{ config, pkgs, ... }: {
  imports = [
    /etc/nixos/hardware-configuration.nix

    # modularized
    ./freshrss.nix
    ./readeck.nix

    # 
    ./syncthing.nix
    ./nextcloud.nix
    ./vaultwarden.nix
  ];

  myModules.freshrss = {
    enable = true;
    adminPassword = "s3cr3t";
    domain = "rss.local";
  };

  myModules.readeck = {
    enable = true;
    port = 9000;
    domain = "readeck.local";
    secretKey = "READECK_SECRET_KEY=mysecretvalue";
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

  virtualisation.docker.enable = true;

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
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    configure = {
      customRC = ''
        " here your custom configuration goes!
        set tabstop=2
        set softtabstop=2
        set shiftwidth=2
        set expandtab
        set smartindent
        set clipboard=unnamedplus
        '';
    };
  };

  services.nginx = {
    enable = true;
    defaultHTTPListenPort = 8123;
  };

  system.stateVersion = "24.11";
}
