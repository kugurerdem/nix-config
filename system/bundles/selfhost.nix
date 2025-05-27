{ config, pkgs, ... }: {
  imports = [ ../modules/selfhost ];

  selfhosting = {
    deployment = "local";
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
