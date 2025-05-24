{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.myModules.freshrss;
in {
  options.myModules.freshrss = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable FreshRSS service";
    };

    adminPassword = mkOption {
      type = types.str;
      default = "test1234";
      description = "Admin password for FreshRSS";
    };

    domain = mkOption {
      type = types.str;
      default = "freshrss";
      description = "Domain name used to access FreshRSS";
    };
  };

  config = mkIf cfg.enable {
    services.freshrss = {
      enable = true;
      defaultUser = "admin";
      passwordFile = pkgs.writeText "freshrsspass" cfg.adminPassword;
      baseUrl = cfg.domain;
      authType = "form";
    };
  };
}
