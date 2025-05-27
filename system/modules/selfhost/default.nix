 { config, lib, ... }:

 with lib;

 let
   cfg = config.selfhosting;
 in {
   options = {
     selfhosting = {
       deployment = {
         type = mkOption {
           type = types.enum [ "local" "production" ];
           default = "local";
           description = "Type of deployment - local or production";
         };
       };
       services = {
         freshrss = {
           enable = mkEnableOption "Enable FreshRSS service";
           domain = mkOption {
             type = types.str;
             description = "Domain for FreshRSS";
           };
         };
         readeck = {
           enable = mkEnableOption "Enable Readeck service";
           domain = mkOption {
             type = types.str;
             description = "Domain for Readeck";
           };
         };
         syncthing = {
           enable = mkEnableOption "Enable Syncthing service";
           domain = mkOption {
             type = types.str;
             description = "Domain for Syncthing";
           };
         };
         nextcloud = {
           enable = mkEnableOption "Enable Nextcloud service";
           domain = mkOption {
             type = types.str;
             description = "Domain for Nextcloud";
           };
         };
       };
     };
   };

   config = mkIf (cfg.services.freshrss.enable || cfg.services.readeck.enable ||
                  cfg.services.syncthing.enable || cfg.services.nextcloud.enable) {

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
