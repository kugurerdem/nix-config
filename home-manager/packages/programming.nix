{pkgs, ...}: {
  home.packages = with pkgs; [
    # nodejs
    nodejs_20
    nodePackages.live-server
    web-ext

    go gotools
    python3

    # build tools
    gnumake
    gcc14
  ];
}
