{ config, pkgs, ... }: {
  imports = [
    /etc/nixos/hardware-configuration.nix

    # modularized
    ./freshrss.nix
    ./readeck.nix

    ./ssl-nginx.nix

    # ./syncthing.nix
    # ./nextcloud.nix
    # ./vaultwarden.nix
  ];

# public vs. private behaviour
# domain'i public ise SSL sertifikasi otomatik olmali
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
  
  networking.extraHosts = ''
  127.0.0.1 rss.local
  127.0.0.1 readeck.local
  '';

  services.nginx = {
    enable = true;
    defaultHTTPListenPort = 8123;
  };

  myModules.sslNginx = {
    enable = false;
    useACME = true;
    # You can also use custom certificates, if you want. But be sure to set
    # useACME to false if you decide to do it that way.
    # sslCertificate = /etc/ssl/mycert.pem;
    # sslCertificateKey = /etc/ssl/private/mycert-key.pem;
    domains = [ "rss.local" "readeck.local" ];
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

  # move it to a more general file
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

  system.stateVersion = "24.11";
}
