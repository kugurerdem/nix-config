{ pkgs ? import <nixpkgs> {}, ... }:

let
    myNeovimConfig = ./init.lua;

    runtimeDependencies = with pkgs; [
        # LSP
        gopls
        nodePackages.typescript-language-server
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
pkgs.writeShellScriptBin "nvim" ''
    export PATH=${pkgs.lib.makeBinPath runtimeDependencies}:$PATH
    exec ${customNeovim}/bin/nvim "$@"
''
