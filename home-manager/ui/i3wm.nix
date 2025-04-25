{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    i3blocks
    dmenu
    flameshot
    light
    pamixer
  ];

  xdg.configFile = builtins.listToAttrs (map (name: {
    name = name;
    value.source = config.lib.file.mkOutOfStoreSymlink (../dotfiles/.config + "/${name}");
  }) [ "i3/config" "i3blocks/config" ]);
}
