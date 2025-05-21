{ config, pkgs, ... }: {
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;

  # Add your users to "libvirtd" group in ./users.nix
}
