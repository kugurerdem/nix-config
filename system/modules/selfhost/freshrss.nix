{lib, ...}: {
  services.freshrss = {
    enable = true;
    defaultUser = "admin";
    passwordFile = lib.mkDefault /etc/secrets/freshrss-password;
    baseUrl = lib.mkDefault "freshrss.local";
    authType = "form";
  };
}
