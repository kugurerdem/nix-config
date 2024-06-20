{ config, pkgs, ... }:

{
    programs.alacritty.enable = true;
    programs.alacritty.settings.window.opacity = 0.9;
    programs.alacritty.settings.colors = {
        # Default colors
        primary = {
            background = "0x0d1117";
            foreground = "0xb3b1ad";
        };

        # Normal colors
        normal = {
            black   =   "0x484f58";
            red     =   "0xff7b72";
            green   =   "0x3fb950";
            yellow  =   "0xd29922";
            blue    =   "0x58a6ff";
            magenta =   "0xbc8cff";
            cyan    =   "0x39c5cf";
            white   =   "0xb1bac4";
        };

        # Bright colors
        bright = {
            black   =   "0x6e7681";
            red     =   "0xffa198";
            green   =   "0x56d364";
            yellow  =   "0xe3b341";
            blue    =   "0x79c0ff";
            magenta =   "0xd2a8ff";
            cyan    =   "0x56d4dd";
            white   =   "0xf0f6fc";
        };

        indexed_colors = [
            { index = 16; color = "0xd18616"; }
            { index = 17; color = "0xffa198"; }
        ];
    };
}
