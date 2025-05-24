{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.myModules.sslNginx;
in {
  options.myModules.sslNginx = {
    enable = mkEnableOption "Enable the SSL Nginx module";

    useACME = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to use Let's Encrypt (ACME) for SSL certificates.";
    };

    sslCertificate = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Path to the SSL certificate (required if useACME = false)";
    };

    sslCertificateKey = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Path to the SSL certificate key (required if useACME = false)";
    };

    domains = mkOption {
      type = types.listOf types.str;
      description = "List of domains to configure with SSL.";
    };
  };

  config = mkIf cfg.enable {
    services.nginx.enable = true;

    security.acme = mkIf cfg.useACME {
      acceptTerms = true;
      defaults.email = "your-email@example.com"; # ⚠️ Replace or expose via config
    };

    services.nginx.virtualHosts = builtins.listToAttrs (
      map (domain: {
        name = domain;
        value = {
          forceSSL = true;
          enableACME = cfg.useACME;
          sslCertificate = mkIf (!cfg.useACME) cfg.sslCertificate;
          sslCertificateKey = mkIf (!cfg.useACME) cfg.sslCertificateKey;
        };
      }) cfg.domains
    );
  };
}
