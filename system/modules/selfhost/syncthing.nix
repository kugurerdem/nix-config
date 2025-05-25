{ config, lib, ... }: {
  options = {
    services.syncthing.guiDomain = lib.options.mkOption {
      type = lib.types.str;
      default = "syncthing.local";
    };
  };
  
  config = {
    services.syncthing = {
      enable = true;
      guiAddress = lib.mkDefault "127.0.0.1:8384";
      settings.gui = lib.mkDefault {
        user = "admin";
        password = builtins.readFile /run/secrets/syncthing-password;
      };
    };

    services.nginx.virtualHosts.${config.services.syncthing.guiDomain} = {
      locations."/" = {
        proxyPass = "http://${config.services.syncthing.guiAddress}";
        proxyWebsockets = true;
      };
    };
  };
}
