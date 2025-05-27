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
  };

  config = lib.mkIf cfg.enable {
    services.freshrss = {
      enable = true;
      defaultUser = "admin";
      passwordFile = "/etc/secrets/freshrss-password";
      baseUrl = cfg.domain;
      authType = "form";
    };

    services.nginx.virtualHosts.${cfg.domain} = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString config.services.freshrss.port}";
        proxyWebsockets = true;
      };
    };
  };
}
