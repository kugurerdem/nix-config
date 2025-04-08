{pkgs, ...}: {
  programs.git = {
    enable = true;
    aliases = {
      a = "add";
      d = "diff";
      dc = "diff --cached";
      s = "status -s";
      ss = "status";
      cm = "commit";
      b = "branch";
      co = "checkout";
      l = "log";
      ls = "log --show-signature";
    };
  };

  programs.lazygit.enable = true;
}
