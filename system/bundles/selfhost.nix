{ config, pkgs, ... }: {
  imports = [
    ../modules/neovim.nix
    ../modules/selfhost/freshrss.nix
    ../modules/selfhost/readeck.nix
    ../modules/selfhost/syncthing.nix
    ../modules/selfhost/nextcloud.nix
    ../modules/selfhost/ssl-nginx.nix
  ];

  selfhosting.services = {
    freshrss = {
      enable = true;
      domain = "freshrss.local";
    };

    readeck = {
      enable = true;
      domain = "readeck.local";
    };

    syncthing = {
      enable = true;
      domain = "syncthing.local";
    };

    nextcloud = {
      enable = true;
      domain = "nextcloud.local";
    };
  };

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

  DomainsToCertifyForNginx = {
    enable = false;
    useACME = true;
    acmeEmail = "ugur@rugu.dev";
    domains = [
      config.selfhosting.services.freshrss.domain
      config.selfhosting.services.readeck.domain
      config.selfhosting.services.syncthing.domain
      config.selfhosting.services.nextcloud.domain
    ];
  };
}
