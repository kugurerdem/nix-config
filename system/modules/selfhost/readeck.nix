{ config, lib, ... }:
let
  cfg = config.selfhosting.readeck;
in {
  options.selfhosting.readeck = {
    enable = lib.mkEnableOption "Readeck service";
    domain = lib.mkOption {
      type = lib.types.str;
      default = "readeck.local";
      description = "Domain for Readeck instance";
    };
    withSSLCert = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to use a self-signed SSL certificate for Nextcloud";
    };
  };

  config = lib.mkIf cfg.enable {
    services.readeck = {
      enable = true;
      settings = {
        main.secret_key = builtins.readFile /etc/secrets/readeck-secret;
        server = {
          base_url = "${if cfg.withSSLCert then "https" else "http"}://${cfg.domain}";
          host = "127.0.0.1";
          port = 9000;
        };
      };
    };

    services.nginx.virtualHosts.${cfg.domain} = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.readeck.settings.server.port}";
        proxyWebsockets = true;
      };
    };
  };
}
