{ config, pkgs, ... }: {
    home = {
        xdg.configFile."i3/config".source = ./dotfiles/.config/i3/config;
        xdg.configFile."i3blocks/config".source = ./dotfiles/.config/i3blocks/config;

        packages = with pkgs; [
          i3blocks
        ];
    };
}
