{pkgs, ...}: {
  home.packages = with pkgs; [
   # minecraft launcher
    (prismlauncher.override { jdks = [
        jdk21
    ]; })
  ];
}
