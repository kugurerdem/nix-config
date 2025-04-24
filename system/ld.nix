{ config, pkgs, ... }: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
      at-spi2-atk
      cairo
      cups
      dbus
      driversi686Linux.mesa
      glib
      mesa
      nspr
      nss
      systemd
      systemdLibs
      systemdMinimal
      systemdUkify
      libdrm
      expat
  ];
}
