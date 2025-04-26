{config, ...}: {
  services.dunst.enable = true;
  xdg.configFile."dunst/dunstrc".source = config.lib.file.mkOutOfStoreSymlink ../dotfiles/.config/dunst/dunstrc;
}
