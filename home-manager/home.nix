{ config, pkgs, ... }:

let
    pass = pkgs.pass.override {
        x11Support = false;
        waylandSupport = false;
        dmenuSupport = false;
    };

    customPkgs = import ../pkgs/default.nix {};
in

{
    imports = [
        # ./neovim.nix
        ./alacritty.nix
        ./newsboat.nix
        ./dwm.nix
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
        # Development
            gnumake
            gcc14
            nodejs_20
            # nodejs_22
            nodePackages.live-server
            web-ext

            postgresql_16

            clojure # repl & compiler
            leiningen # project manager for clojure
            babashka # an interpreter

            python3
            git
            lazygit
            zellij # favorite Terminal Multiplexer

            hugo

        # TUI/CLI Utilities
            neofetch

            ctpv # previews for lf
            lf # TUI file manager
            fasd
            ripgrep

            pamixer # used for setting sound
            acpi # used for seeing battery

            zip unzip

            (pass.withExtensions (ext: with ext; [passExtensions.pass-otp]))
            zbar # decode bar codes from image files, can be used with pass-top

            entr # Watch file changes
            moreutils # COOL Linux utilities like vipe, vidir, etc.
            xsv # Great tool for working with CSV through CLI
            jq # JSON Parser

            rlwrap

            tree

            pandoc # conversion between document formats

            rsync # for syncing files between directories
            inetutils # ifconfig, ping, traceroute, ftp, and so on...
            tcpdump # Network sniffer
            bind # contains nslookup and dig
            android-tools # have adb in it
            ffmpeg_7-full

            yt-dlp

        # Desktop/GUI programs
            alacritty # my favorite terminal

            xfce.thunar # file manager
            xfce.tumbler

            blueberry # bluetooth manager GUI
            telegram-desktop
            signal-desktop
            libreoffice-qt
            vlc # The VLC media player
            obsidian # note taking
            sxiv # image viewer
            okular # PDF Reader
            stremio # watch movies/tv-series

            openshot-qt
            simplescreenrecorder # screen recording program

            (prismlauncher.override { jdks = [
                jdk21
            ]; }) # minecraft launcher

            customPkgs.neovim
        ];

        file.".inputrc".source = ./dotfiles/.inputrc;
        file.".gitconfig".source = ./dotfiles/.gitconfig;

        sessionPath = [ "$HOME/.local/bin" ];
        file.".local/bin" = {
            source = ./dotfiles/.local/bin;
            recursive = true;
            executable = true;
        };
    };

    xdg.configFile.zellij.source = ./dotfiles/.config/zellij;

    programs.bash = {
        enable = true;
        shellAliases = {
            rebuild = "sudo nixos-rebuild switch";

            sudo = "sudo ";
            ll = "ls -pF";
            lg = "lazygit";
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

            [ -f "$HOME/.local/bin/fasd-init.sh" ] \
                && source $HOME/.local/bin/fasd-init.sh
        '';
    };

    programs.fzf = {
        enable = true;
        enableBashIntegration = true;
    };

    programs.feh.enable = true;
    services.picom = {
        enable = true;
        fade = true;
        fadeSteps = [0.07 0.07];
    };

    programs.chromium = {
        enable = true;
        package = pkgs.brave;
        extensions = [
            { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
            { id = "kbfnbcaeplbcioakkpcpgfkobkghlhen"; } # Grammarly
            { id = "clngdbkpkpeebahjckkjfobafhncgmne"; } # Stylus
            { id = "pobhoodpcipjmedfenaigbeloiidbflp"; } # Minimal Theme for Twitter
            { id = "khncfooichmfjbepaaaebmommgaepoid"; } # YouTube Unhooked
            { id = "lggmmceliiaoddfnbaccgpfnpoifilic"; } # Bell of Mindfulness
            { id = "khgegkjchclhgpglloficdmdannlpmoi"; } # What Hackernews Says?
        ];
    };

    programs.firefox.enable = true;

    programs.gpg.enable = true;
    services.gpg-agent.enable = true;
    services.gpg-agent.defaultCacheTtl = 3000;
    services.gpg-agent.pinentryPackage = pkgs.pinentry-gtk2;
}
