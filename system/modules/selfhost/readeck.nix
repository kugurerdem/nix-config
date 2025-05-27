{pkgs, lib, config, ...}: {
  services.readeck = {
    enable = true;
    settings.main.secret_key = lib.mkDefault (builtins.readFile /etc/secrets/readeck-secret);
    settings.server.base_url = lib.mkDefault "readeck.local";
    settings.server.host = lib.mkDefault "0.0.0.0";
    settings.server.port = lib.mkDefault 9000;
  };

  services.nginx.virtualHosts.${config.services.readeck.settings.server.base_url} = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.readeck.settings.server.port}";
      proxyWebsockets = true;
    };
  };
}
