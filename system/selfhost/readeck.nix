{pkgs, lib, config, ...}:

with lib;

let
  cfg = config.myModules.readeck;
in {
  options.myModules.readeck = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable the Readeck service and related configuration.";
    };

    port = mkOption {
      type = types.port;
      default = 9000;
      description = "Port on which Readeck listens.";
    };

    domain = mkOption {
      type = types.str;
      default = "readeck";
      description = "Domain used for Readeck virtual host.";
    };

    secretKey = mkOption {
      type = types.str;
      default = "READECK_SECRET_KEY=test";
      description = "Secret key content for Readeck.";
    };
  };

  config = mkIf cfg.enable {
    services.readeck = {
      enable = true;
      settings.server.port = cfg.port;
      environmentFile = pkgs.writeText "readeck-env" cfg.secretKey;
    };

    services.nginx.virtualHosts.${cfg.domain} = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        proxyWebsockets = true;
      };
    };
  };
}

