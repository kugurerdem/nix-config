{...} : {
  services.syncthing = {
    enable = true;
    relay.enable = true;
    guiAddress = "127.0.0.1:8384";

    settings.gui = {
      user = "rugu";
      password = "test1234"; # TODO: get this from a file
    };
  };

  services.nginx.virtualHosts."syncthing" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:8384";
      proxyWebsockets = true;
    };
  };

  networking.extraHosts = "127.0.0.1 syncthing";
}
