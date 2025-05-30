{ config, lib, ... }:
let
  cfg = config.selfhosting.vaultwarden;
in {
  options.selfhosting.vaultwarden = {
    enable = lib.mkEnableOption "VaultWarden service";
    domain = lib.mkOption {
      default = "vaultwarden.local";
      type = lib.types.str;
      description = "Base URL for the service";
    };
    withSSLCert = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to use SSL certificate while serving the service";
    };
  };

  config = lib.mkIf cfg.enable {
    services.vaultwarden = {
      enable = true;
      environmentFile = "/etc/secrets/vaultwarden.env";
      config = {
        DOMAIN = "${if cfg.withSSLCert then "https" else "http"}://${cfg.domain}";
        SIGNUPS_ALLOWED = false;

        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;

        ROCKET_LOG = "critical";
        LOG_FILE = "/var/lib/bitwarden_rs/access.log";
      };
    };

    services.nginx.virtualHosts."${cfg.domain}".locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
      proxyWebsockets = true;
      extraConfig = ''
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
      '';
    };
  };
}
