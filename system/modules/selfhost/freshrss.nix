{lib, ...}:
  let cfg = options.selfhosting.freshrss;
in
{
  options.freshrss = {
    enable = lib.mkEnableOption "FreshRSS";
    domain = lib.mkOption {
      type = lib.types.str;
      default = "freshrss.local";
      description = "Base URL for FreshRSS instance.";
    };
  };

  config = {
    services.freshrss = {
      enable = lib.mkEnableOption "FreshRSS service";
      defaultUser = lib.mkDefault "admin";
      passwordFile = lib.mkDefault "/etc/secrets/freshrss-password";
      baseUrl = lib.mkDefault "freshrss.local";
      authType = lib.mkDefault "form";
    };
  };
  # services.freshrss = {
  #   enable = true;
  #   defaultUser = "admin";
  #   passwordFile = lib.mkDefault /etc/secrets/freshrss-password;
  #   baseUrl = lib.mkDefault "freshrss.local";
  #   authType = "form";
  # };
}
