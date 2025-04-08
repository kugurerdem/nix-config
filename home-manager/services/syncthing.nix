{...} : {
  services.syncthing = {
    enable = true;
    extraOptions = [
      "--gui-address=localhost:8384"
    ];
  };
}
