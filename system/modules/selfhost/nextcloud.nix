{pkgs, lib, ...}: {
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = lib.mkDefault "nextcloud.local";
    config.adminpassFile = lib.mkDefault "/run/secrets/nextcloud-admin-password";
    config.dbtype = "sqlite";
  };
}
