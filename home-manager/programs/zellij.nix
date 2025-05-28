{config, ...}: {
  programs.zellij = {
    enable = true;
  };
  xdg.configFile."zellij/config.kdl".source = config.lib.file.mkOutOfStoreSymlink (../dotfiles/.config/zellij/config.kdl);
}
