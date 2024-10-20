{ pkgs ? import <nixpkgs> {}, ... }:

let
    myNeovimConfig = ./init.lua;

    runtimeDependencies = with pkgs; [
        # LSP
        gopls
        # nodePackages.typescript-language-server
        nodePackages_latest.typescript-language-server
        vscode-langservers-extracted
        rust-analyzer
        lua-language-server
        clojure-lsp

        # Tools
        go
        clojure
    ];

    plugins = with pkgs.vimPlugins; [
        vim-commentary
        vim-airline
        awesome-vim-colorschemes
        copilot-vim
        nvim-lspconfig

        conjure # for clojure REPL integration
        vim-sexp
    ];

    customNeovim = pkgs.neovim.override {
        configure = {
            customRC = ''
                luafile ${./init.lua}
            '';
            packages.customPlugins = {
                start = plugins;
            };
        };
    };
in

# TODO: Find a way to hide runtimeDependencies from host, but make them still
# available to Neovim (kindof like extraPackage parameter in home-manager)
# TODO: this does not work as expected. Not all executables are in bin.
pkgs.symlinkJoin {
    name = "rugu-neovim";
    paths = runtimeDependencies ++ [customNeovim];
}
