{...} :

let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "nixos-25.05";
  });
in
{
  imports = [ nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;

    nixpkgs.config = { allowUnfree = true; };

    clipboard = {
      providers = {
        xclip.enable = true;
        wl-copy.enable = true;
      };
      register = "unnamedplus";
    };

    autoCmd = [
      {
        event = "FileType";
        pattern = "go";
        callback.__raw = ''
          function()
          -- Indentation settings
          vim.opt_local.expandtab = false
          vim.opt.list = false
          end
          '';
      }
      {
        event = "BufWritePost";
        pattern = "go";
        callback.__raw = ''
          function()
          -- Format on save
          vim.cmd("!goimport -w % && gofmt -w %")
          end
          '';
      }
      {
        event = "FileType";
        pattern = "nix";
        callback.__raw = ''
          function()
          -- Indentation settings
          vim.opt_local.expandtab = true
          vim.opt_local.tabstop = 2
          vim.opt_local.softtabstop = 2
          vim.opt_local.shiftwidth = 2
          end
          '';
      }
    ];

    extraConfigLua = ''
      vim.opt.expandtab = true -- Converts tabs to white space
      vim.opt.tabstop = 4 -- Number of columns occupied by a tab
      vim.opt.softtabstop = 4 -- See multiple spaces as tabstops so <BS> does the right thing
      vim.opt.shiftwidth = 4 -- Width for autoindents
      vim.opt.list = true
      vim.opt.listchars = { trail = '@' }
    vim.opt.number = true
      vim.opt.relativenumber = true


      local function soft_wrap()
      vim.wo.wrap = true
      vim.wo.linebreak = true
      vim.o.columns = 80
      print("Wrap and linebreak on; columns set to 80")
      end

      vim.api.nvim_create_user_command("SoftWrap", soft_wrap, {})

      -- hotkeys
      vim.api.nvim_set_keymap(
          'n', '<leader>c', ':set cc=80<CR>', { noremap = true, silent = true })

      vim.api.nvim_set_keymap(
          'n', '<leader>C', ':set cc=0<CR>', { noremap = true, silent = true })

      vim.api.nvim_set_keymap(
          'n', '<leader>n', ':noh<CR>', { noremap = true, silent = true })

      vim.diagnostic.config({
          virtual_text = {
          prefix = "●",      -- Symbol before the message
          spacing = 4,       -- Space between code and message
          source = "if_many" -- Show source name if multiple LSPs attach
          },
          })
    '';

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;

    plugins.vim-surround.enable = true;
    plugins.vim-css-color.enable = true;
    plugins.markdown-preview.enable = true;

    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>sh" = {
          action = "help_tags";
          options = {
            desc = "[S]earch [H]elp";
          };
        };
        "<leader>sk" = {
          action = "keymaps";
          options = {
            desc = "[S]earch [K]eymaps";
          };
        };
        "<leader>sf" = {
          action = "find_files";
          options = {
            desc = "[S]earch [F]iles";
          };
        };
        "<leader>ss" = {
          action = "builtin";
          options = {
            desc = "[S]earch [S]elect Telescope";
          };
        };
        "<leader>sw" = {
          action = "grep_string";
          options = {
            desc = "[S]earch current [W]ord";
          };
        };
        "<leader>sg" = {
          action = "live_grep";
          options = {
            desc = "[S]earch by [G]rep";
          };
        };
        "<leader>sd" = {
          action = "diagnostics";
          options = {
            desc = "[S]earch [D]iagnostics";
          };
        };
        "<leader>sr" = {
          action = "resume";
          options = {
            desc = "[S]earch [R]esume";
          };
        };
        "<leader>s." = {
          action = "oldfiles";
          options = {
            desc = "[S]earch Recent Files (\".\") for repeat";
          };
        };
        "<leader><leader>" = {
          action = "buffers";
          options = {
            desc = "[ ] Find existing buffers";
          };
        };
      };
    };
    plugins.web-devicons.enable = true;

    plugins.lsp = {
      enable = true;
      servers = {
        gopls = { enable = true; };
        ts_ls = { enable = true; };
        eslint = { enable = true; };
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        lua_ls = { enable = true; };
        nixd = { enable = true; };
      };
    };

    plugins.copilot-vim = {
      enable = true;
      settings.filetypes = {
        "*" = false;
        clojure = true;
        cmake = true;
        cpp = true;
        css = true;
        c = true;
        dockerfile = true;
        gitcommit = true;
        go = true;
        haskell = true;
        html = true;
        h = true;
        javascriptreact = true;
        javascript = true;
        java = true;
        json = true;
        jsx = true;
        lisp = true;
        lua = true;
        make = true;
        nix = true;
        python = true;
        rust = true;
        shell = true;
        sh = true;
        sql = true;
        toml = true;
        typescript = true;
        vim = true;
        yaml = true;
      };
    };
  };
}
