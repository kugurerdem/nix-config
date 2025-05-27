 { config, lib, ... }:

 with lib;

 let
   cfg = config.selfhosting;
 in {
   options = {
     selfhosting = {
       enable = lib.mkEnableOption "Enable self-hosting services";
       deploymentType = mkOption {
         type = types.enum [ "local" "production" ];
         default = "local";
         description = "Type of deployment - local or production";
       };
     };
   };

   config = mkIf (cfg.enable) {

     networking.extraHosts = mkIf (cfg.deployment.type == "local") ''
       127.0.0.1 ${cfg.services.freshrss.domain}
       127.0.0.1 ${cfg.services.readeck.domain}
       127.0.0.1 ${cfg.services.syncthing.domain}
       127.0.0.1 ${cfg.services.nextcloud.domain}
     '';

     DomainsToCertifyForNginx = mkIf (cfg.deployment.type == "production") {
       enable = true;
       useACME = true;
       acmeEmail = "ugur@rugu.dev";
       domains = [
         cfg.services.freshrss.domain
         cfg.services.readeck.domain
         cfg.services.syncthing.domain
         cfg.services.nextcloud.domain
       ];
     };

     services.nginx = {
       enable = true;
       defaultHTTPListenPort = 80;
     };
   };
 }
