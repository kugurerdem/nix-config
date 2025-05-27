{ config, lib, ... }:
let
  cfg = config.selfhosting.services.freshrss;
in {
  options.selfhosting.services.freshrss = {
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
  };
}
