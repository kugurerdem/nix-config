{ config, pkgs, ... }: {
  imports = [ ../modules/selfhost ];

  selfhosting = {
    freshrss = {
      enable = true;
      domain = "freshrss.local";
      withSSLCert = false;
    };

    readeck = {
      enable = true;
      domain = "readeck.local";
      withSSLCert = false;
    };

    syncthing = {
      enable = true;
      domain = "syncthing.local";
      withSSLCert = false;
    };

    nextcloud = {
      enable = true;
      domain = "nextcloud.local";
      withSSLCert = false;
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "ugur@rugu.dev";
  };
}
