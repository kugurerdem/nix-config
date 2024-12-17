{ pkgs ? import <nixpkgs> {} }:

{
    neovim = pkgs.callPackage ./neovim {};
    zellij = pkgs.callPackage ./zellij {};
}
