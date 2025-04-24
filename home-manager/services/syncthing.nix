{...} : {
  services.syncthing = {
    enable = true;
    tray.enable = true;
    extraOptions = [
      "--gui-address=localhost:8384"
    ];
  };
}
