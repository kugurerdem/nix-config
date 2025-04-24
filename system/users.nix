{ config, pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rugu = {
    isNormalUser = true;
    description = "rugu";
    extraGroups = [ "networkmanager" "wheel" "audio" "sound" "video" "docker"];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  security.sudo.wheelNeedsPassword = false;
}
