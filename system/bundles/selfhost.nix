{ config, pkgs, ... }: {
  imports = [
    ../modules/neovim.nix

    ../modules/selfhost/freshrss.nix
    ../modules/selfhost/readeck.nix
    ../modules/selfhost/syncthing.nix
    ../modules/selfhost/nextcloud.nix

    ../modules/selfhost/ssl-nginx.nix
  ];

  # TODO: maybe put these in a more uniform form
  services.freshrss.baseUrl = "rss.local";
  services.readeck.settings.server.base_url = "readeck.local";
  services.syncthing.guiDomain = "syncthing.local";
  services.nextcloud.hostName = "nextcloud.local";

  # TODO: maybe DRY
  # TODO, either this should run or domains to certify for nginx
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
    # You can also use custom certificates, if you want. But be sure to set
    # useACME to false if you decide to do it that way.
    # sslCertificate = /etc/ssl/mycert.pem;
    # sslCertificateKey = /etc/ssl/private/mycert-key.pem;
    domains = [ "freshrss.local" "readeck.local" "syncthing.local" "nextcloud.local" ];
  };
}
