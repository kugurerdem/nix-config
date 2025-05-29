{...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    configure = {
      customRC = ''
        " here your custom configuration goes!
        set tabstop=2
        set softtabstop=2
        set shiftwidth=2
        set expandtab
        set smartindent
        set clipboard=unnamedplus
        '';
    };
  };
}
