{ config, pkgs, ... }:

{
    imports = [
        ./gnome.nix
        ./dwm.nix
        ./i3wm.nix

        ./fish.nix
        ./bash.nix

        ./programs/git.nix
        ./programs/alacritty.nix
        ./programs/chromium.nix
        ./programs/direnv.nix
        ./programs/newsboat.nix
        ./programs/feh.nix
        ./programs/gpg.nix
        ./programs/subversion.nix

        ./packages/docker.nix
        ./packages/postgres.nix
        ./packages/programming.nix
        ./packages/cli-utils.nix
        ./packages/gui/media/players.nix
        ./packages/gui/media/editors.nix
        ./packages/gui/gaming/minecraft.nix
        ./packages/gui/office.nix
        ./packages/gui/communication.nix
        ./packages/gui/utilities.nix

        ./services/picom.nix
        ./services/syncthing.nix
        ./services/gpg-agent.nix
        ./services/udiskie.nix
        ./services/cbatticon.nix
    ];

    # TODO: Enter your own email and name
    programs.git = {
      userEmail = "email@gmail.com";
      userName = "username";
    };

    home = {
        # TODO: Enter your own username and home directory
        username = "rugu";
        homeDirectory = "/home/rugu";
        stateVersion = "24.11";

        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
          PAGER = "less";
        };

        shellAliases = {
          sudo = "sudo ";
          ll = "ls -pF";
          lg = "lazygit";
          e = "edit_file_opened_by_fzf";
          diary = ''$EDITOR $HOME/Documents/my/diary/$(date +%G).md'';
        };

        sessionPath = [ "$HOME/.local/bin" ];

        file.".local/bin" = {
            source = ./dotfiles/.local/bin;
            recursive = true;
            executable = true;
        };

        file.".inputrc".source = ./dotfiles/.inputrc;
    };

    programs.home-manager.enable = true;
}
