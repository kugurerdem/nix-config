{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
      fish_vi_key_bindings

      function edit_file_opened_by_fzf
      set file (fzf)
      if test -n "$file"
        nvim "$file"
      end
      end
      '';
    plugins = [
    {
      name = "fasd";
      src = pkgs.fetchFromGitHub {
        owner = "oh-my-fish";
        repo = "plugin-fasd";
        rev = "38a5b6b6011106092009549e52249c6d6f501fba";
        sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
      };
    }
    ];
  };


  xdg.configFile."fish/functions" = {
    source = ./dotfiles/.config/fish/functions;
    recursive = true;
  };
}
