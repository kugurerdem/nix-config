 { config, lib, ... }:

 with lib;

 let
   cfg = config.selfhosting;

   _services = [
     cfg.freshrss
     cfg.readeck
     cfg.syncthing
     cfg.nextcloud
     cfg.vaultwarden
     cfg.goatcounter
   ];
 in {
    imports = [
      ./freshrss.nix
      ./nextcloud.nix
      ./readeck.nix
      ./syncthing.nix
      ./vaultwarden.nix
      ./goatcounter.nix
    ];

   config = {
     networking.extraHosts =
       lib.concatStringsSep "\n" (map (s: "127.0.0.1 ${s.domain}") _services);

    services.nginx = {
      enable = true;
      defaultHTTPListenPort = 80;

      virtualHosts = builtins.listToAttrs (
        map (s: {
          name = s.domain;
          value = {
            forceSSL = true;
            enableACME = true;
          };
        })
        (builtins.filter (service: service.withSSLCert) _services)
      );
    };
   };
 }
