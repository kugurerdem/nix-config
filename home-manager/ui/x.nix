{config, pkgs, ...}: {
  home.packages = with pkgs; [
    xclip xsel # clipboard utils
    xorg.xkill
  ];

  home.file = builtins.listToAttrs (map (name: {
    name = name;
    value.source = config.lib.file.mkOutOfStoreSymlink (../dotfiles + "/${name}");
  }) [ ".xinitrc" ".Xresources" ".xprofile" ]);
}
