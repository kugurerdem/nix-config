{ config, lib, ... }:
let
  cfg = config.selfhosting.freshrss;
in {
  options.selfhosting.freshrss = {
    enable = lib.mkEnableOption "FreshRSS service";
    domain = lib.mkOption {
      type = lib.types.str;
      default = "freshrss.local";
      description = "Base URL for FreshRSS instance";
    };
    withSSLCert = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to use a self-signed SSL certificate for Nextcloud";
    };
  };

  config = lib.mkIf cfg.enable {
    services.freshrss = {
      enable = true;
      defaultUser = "admin";
      passwordFile = "/etc/secrets/freshrss-password";
      baseUrl = "${if cfg.withSSLCert then "https" else "http"}://${cfg.domain}";
      virtualHost = cfg.domain;
      authType = "form";
    };
  };
}
