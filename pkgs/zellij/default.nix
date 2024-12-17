{ pkgs ? import <nixpkgs> {}, ... }:

pkgs.writeShellScriptBin "zellij" ''
    exec ${pkgs.zellij}/bin/zellij --config ${./config.kdl} "$@"
''
