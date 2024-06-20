{ config, pkgs, ... }:

let
    dwm = pkgs.dwm.overrideAttrs {
        src = fetchGit {
            url = "https://github.com/kugurerdem/dwm.git";
        };
    };

    dwmblocks = pkgs.dwmblocks.overrideAttrs {
        src = fetchGit {
            url = "https://github.com/kugurerdem/dwmblocks.git";
        };
    };

in
{
    imports = [
        ./neovim.nix
        ./alacritty.nix
    ];

    home = {
        username = "rugu";
        homeDirectory = "/home/rugu";
        stateVersion = "24.05";
        sessionVariables = {
            EDITOR = "nvim";
            VISUAL = "nvim";
            PAGER = "less";
        };
        packages = with pkgs; [
            brave

            zellij
            git
            neofetch

            # window manager stuff
            dwm
            dwmblocks
            dmenu

            xclip
            xsel

            # required by dwmblocks
            pamixer
            acpi

            alacritty

            # Development
            nodejs_22

            # Shell utilities
            autojump
            lf

            pass
        ];

        file.".inputrc".source = ./dotfiles/.inputrc;
        file.".xinitrc".source = ./dotfiles/.xinitrc;
        file.".gitconfig".source = ./dotfiles/.gitconfig;
    };

    programs.bash = {
        enable = true;
        shellAliases = {
            rebuild = "sudo nixos-rebuild switch";

            sudo = "sudo ";
            ll = "ls -pF";
            e = "edit_file_opened_by_fzf";
            diary = ''$EDITOR $HOME/Documents/my/diary/$(date +%G).md'';
        };
        bashrcExtra = ''
            bind -m vi-command 'Control-l: clear-screen'
            bind -m vi-insert 'Control-l: clear-screen'

            function edit_file_opened_by_fzf() {
                local file
                file=$(fzf)
                if [[ -n $file ]]; then
                    nvim "$file"
                fi

            }
        '';
        profileExtra = "startx";
    };

    programs.fzf = {
        enable = true;
        enableBashIntegration = true;
    };

    services.picom = {
        enable = true;
        fade = true;
        fadeSteps = [0.07 0.07];
    };

    programs.gpg.enable = true;
    services.gpg-agent.enable = true;
    services.gpg-agent.defaultCacheTtl = 3000;
    services.gpg-agent.pinentryPackage = pkgs.pinentry-gtk2;

    home.file.".local/bin" = {
        source = ./dotfiles/.local/bin;
        recursive = true;
        executable = true;
    };
}
