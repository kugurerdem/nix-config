{ pkgs, config, lib, ... }:
let
  cfg = config.selfhosting.goatcounter;
  goatcounterDir = "/var/lib/goatcounter";
in {
  options.selfhosting.goatcounter = {
    enable = lib.mkEnableOption "Enable GoatCounter service";
    domain = lib.mkOption {
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
    services.goatcounter = {
      enable = true;
      package = pkgs.goatcounter;
      port = 5000;
      address = "127.0.0.1";
      extraArgs = [ "-tls" "none" ];
    };

    services.nginx.virtualHosts.${cfg.domain} = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:5000";
        proxyWebsockets = true;
      };
    };
  };
}
