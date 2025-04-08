{pkgs, ...}: {
  home.packages = with pkgs; [
    audacity          # Audio editing
    shotcut           # Video editing
    simplescreenrecorder  # Screen recording
    ffmpeg_7-full     # Command-line media processing
    inkscape          # Vector graphics editing
  ];
}
