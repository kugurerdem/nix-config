{pkgs, ...}:

let
    pass = pkgs.pass.override {
        x11Support = false;
        waylandSupport = false;
        dmenuSupport = false;
    };
in

# TODO: This file can be further modularized
{
  home.packages = with pkgs; [
    hugo
    less

    nix-index
    nix-tree
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

    killall
  ];
}
