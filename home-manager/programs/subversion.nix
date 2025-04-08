{ pkgs, ... }:

let
    customSubversion = pkgs.subversion.overrideAttrs (oldAttrs: rec {
        src = pkgs.fetchurl {
            url = "mirror://apache/subversion/subversion-1.10.8.tar.bz2";
            sha256 = "sha256-CnO6MSe1ov/7j+4rcCmE8qgI3nEKjbKLfdQBDYvlDlo=";
        };
    });
in

{
    home = {
        packages = with pkgs; [
          customSubversion
        ];
    };
}
