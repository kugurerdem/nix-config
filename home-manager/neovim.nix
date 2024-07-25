{ config, pkgs, ...} :

{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;

    extraPackages = with pkgs; [
        # LSP
        gopls
        nodePackages.typescript-language-server
        vscode-langservers-extracted
        rust-analyzer
        lua-language-server

        # Tools
        go
    ];
        plugins = with pkgs.vimPlugins; [
            vim-commentary
            vim-airline
            awesome-vim-colorschemes
            copilot-vim
            nvim-lspconfig
        ];
    };

    xdg.configFile.nvim.source = ./dotfiles/.config/nvim;
}
