{ config, pkgs, ... }: {
  imports = [ ../modules/selfhost ];

  selfhosting = {
    enable = true;
    deploymentType = "local";
    services = {
      freshrss = {
        enable = true;
        domain = "freshrss.local";
      };

      readeck = {
        enable = true;
        domain = "readeck.local";
      };

      syncthing = {
        enable = true;
        domain = "syncthing.local";
      };

      nextcloud = {
        enable = true;
        domain = "nextcloud.local";
      };
    };
  };
}
