{ config, lib, ... }:
let
  cfg = config.selfhosting.syncthing;
in {
  options.selfhosting.syncthing = {
    enable = lib.mkEnableOption "Syncthing service";
    domain = lib.mkOption {
      type = lib.types.str;
      default = "syncthing.local";
      description = "Domain for Syncthing Web GUI";
    };
    withSSLCert = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to use a self-signed SSL certificate for Nextcloud";
    };
  };

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      guiAddress = "127.0.0.1:8384";
      settings.gui = {
        user = "admin";
        password = builtins.readFile /etc/secrets/syncthing-password;
      };
    };

    services.nginx.virtualHosts.${cfg.domain} = {
      locations."/" = {
        proxyPass = "http://${config.services.syncthing.guiAddress}";
        proxyWebsockets = true;
      };
    };
  };
}
