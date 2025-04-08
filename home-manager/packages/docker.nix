{pkgs, ...}: {
  home.packages = with pkgs; [
    docker
    docker-compose
    lazydocker
  ];
}
