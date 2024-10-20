{ pkgs ? import <nixpkgs> {} }:

{
    neovim = pkgs.callPackage ./neovim {};
}
