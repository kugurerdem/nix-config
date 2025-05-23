{ pkgs, ... }: {
  services.vaultwarden = {
    enable = true;
# TODO: put a strong secret key in environment variable for bitwarden to run
    environmentFile = "${pkgs.writeText "vaultwarden-pw" "ADMIN_TOKEN=asdfkljadsfkdja283823"}";
  };
}

