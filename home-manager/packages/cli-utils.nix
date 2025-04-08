{pkgs, ...}:

let
    pass = pkgs.pass.override {
        x11Support = false;
        waylandSupport = false;
        dmenuSupport = false;
    };

    customPkgs = import ../../pkgs/default.nix {};
in

# TODO: This file can be further modularized
{
  home.packages = with pkgs; [
    hugo

    nix-index
    neofetch

    ctpv # previews for lf
    lf # TUI file manager
    fasd
    ripgrep

    pamixer # used for setting sound
    acpi # used for seeing battery

    zip unzip p7zip

    (pass.withExtensions (ext: with ext; [passExtensions.pass-otp]))
    zbar # decode bar codes from image files, can be used with pass-top

    lsof
    entr # Watch file changes
    moreutils # COOL Linux utilities like vipe, vidir, etc.
    xsv # Great tool for working with CSV through CLI
    jq # JSON Parser

    rlwrap

    tree

    pandoc # conversion between document formats
    tectonic

    rsync # for syncing files between directories
    android-tools # have adb in it

    yt-dlp

    # networking
    inetutils
    tcpdump
    bind
    android-tools

    customPkgs.neovim
    customPkgs.zellij
  ];
}
