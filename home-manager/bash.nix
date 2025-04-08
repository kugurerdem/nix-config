{ config, pkgs, ...} :

{
  programs.bash = {
      enable = true;
      shellAliases = {
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
}
