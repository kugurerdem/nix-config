{ config, pkgs, lib, ... }:
let
  cfg = config.selfhosting.nextcloud;
in {
  options.selfhosting.nextcloud = {
    enable = lib.mkEnableOption "Nextcloud service";
    domain = lib.mkOption {
      type = lib.types.str;
      default = "nextcloud.local";
      description = "Domain for Nextcloud instance";
    };
    withSSLCert = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to use a self-signed SSL certificate for Nextcloud";
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
