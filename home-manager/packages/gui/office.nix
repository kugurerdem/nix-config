{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice-qt
    obsidian # note taking
    logseq # note taking
  ];
}
