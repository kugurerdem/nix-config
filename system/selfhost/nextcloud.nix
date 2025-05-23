{pkgs, ...}: {
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = "nextcloud";
    config.adminpassFile = "${pkgs.writeText "nextcloudpass" "test1234"}";
    config.dbtype = "sqlite";
  };

  networking.extraHosts = "127.0.0.1 nextcloud";
}
