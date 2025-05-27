{ config, pkgs, lib, ... }:
let
  cfg = config.selfhosting.services.nextcloud;
in {
  options.selfhosting.services.nextcloud = {
    enable = lib.mkEnableOption "Nextcloud service";
    domain = lib.mkOption {
      type = lib.types.str;
      default = "nextcloud.local";
      description = "Domain for Nextcloud instance";
    };
  };

  config = lib.mkIf cfg.enable {
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      hostName = cfg.domain;
      config = {
        adminpassFile = "/etc/secrets/nextcloud-admin-password";
        dbtype = "sqlite";
      };
    };
  };
}
