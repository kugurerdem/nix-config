{ pkgs, ... }: {
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 3000;
    pinentryPackage = pkgs.pinentry-gtk2;
  };
}
