{
  config,
  pkgs,
  lib,
  ...
}:

let
  myFont = "JetBrainsMono Nerd Font Mono";
in

{
  home.username = "tim";
  home.homeDirectory = "/home/tim";

  home.packages = with pkgs; [
    # command line utilities
    btop
    delta
    direnv
    eza
    fastfetch
    fzf
    git
    git-lfs
    ghostty
    jq
    just
    kitty
    nixfmt-rfc-style
    ripgrep
    starship
    tmux
    vim
    wget
    yazi
    zoxide

    # Not a nerdfont
    maple-mono.NF-CN-unhinted

    zed-editor

    # Python dev support
    ruff
    pyright
    python3

    # Language servers for JSON/YAML/Docker/Nix
    nodejs
    yaml-language-server
    vscode-langservers-extracted # includes json-language-server
    dockerfile-language-server-nodejs
    nil # Nix language server
    nixd
    odin # Odin compiler
    ols

    # sublime text editor
    sublime4-dev
    sublime-merge

    # Language servers for programming
    docker-language-server
    nodejs_24
    nodePackages.vscode-json-languageserver
    pyright
    yaml-language-server
    bash-language-server # Bash LSP

    # 'GUI' programs
    audacity
    citrix_workspace # needs a manual download due to enduser license agreements
    obsidian
    orca-slicer
    slack
    spotify
    swaybg
    variety
    networkmanagerapplet
  ];

  imports = [
    (import ./applications/vscode.nix { inherit pkgs myFont; })
    (import ./applications/kitty.nix { inherit myFont; })
    (import ./applications/tmux.nix { inherit pkgs; })
    ./applications/shell.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.file.".gitconfig".text = ''
    [core]
        pager = delta

    [interactive]
        diffFilter = delta --color-only

    [delta]
        navigate = true  # use n and N to move between diff sections
        dark = true      # or light = true, or omit for auto-detection

    [merge]
        conflictStyle = zdiff3
  '';

  # Make sure that I can use my ssh settings while in a devcontianer:
  home.file.".ssh/config".text = ''
    AddKeysToAgent yes

    # NOTE: this is used for RWS datalab
    HOST gitlab.com
        Hostname altssh.gitlab.com
        User git
        Port 443
  '';

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.zed-editor = {
    enable = true;
    extensions = [
      "python"
      "ruff"
      "pyright"
      "json"
      "yaml"
      "dockerfile"
      "nix"
      "bash"
      "odin"
    ];
    userSettings = {
      assistant = {
        enable = false;
      };
      buffer_font_family = "${myFont}";
      buffer_font_size = 17;
      line_height = "comfortable";
      hour_format = "hour24";
      auto_update = false;
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Dark";
      };
      show_whitespaces = "selection";
      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = true;
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
            ];
            activate_script = "default";
          };
        };
        env = {
          TERM = "alacritty";
        };
        font_family = "${myFont}";
        font_size = 15;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };

      lsp = {
        nix = {
          binary = {
            path_lookup = true;
          };
        };
        pyright = {
          binary = {
            path = "${pkgs.pyright}/bin/pyright-langserver";
            arguments = [ "--stdio" ];
          };
        };
        ruff = {
          format_on_save = true;
          binary = {
            path = "${pkgs.ruff}/bin/ruff";
            arguments = [ "server" ];
          };
        };
      };

      languages = {
        python = {
          language_servers = [
            "pyright"
            "ruff"
          ];
        };
      };
    };
  };
  #         "formatter": {
  #           "command": ["${pkgs.ruff}/bin/ruff", "format", "-"]
  #         },
  #         "ruff": {
  #           "path": "${pkgs.ruff}/bin/ruff"
  #         },
  #         "language_server": {
  #           "command": ["${pkgs.pyright}/bin/pyright-langserver", "--stdio"]
  #         }
  #       },
  #       "json": {
  #         "format_on_save": true,
  #         "language_server": {
  #           "command": ["${pkgs.vscode-langservers-extracted}/bin/json-languageserver", "--stdio"]
  #         }
  #       },
  #       "yaml": {
  #         "format_on_save": true,
  #         "language_server": {
  #           "command": ["${pkgs.yaml-language-server}/bin/yaml-language-server", "--stdio"]
  #         }
  #       },
  #       "dockerfile": {
  #         "format_on_save": true,
  #         "language_server": {
  #           "command": ["${pkgs.dockerfile-language-server-nodejs}/bin/docker-langserver", "--stdio"]
  #         }
  #       },
  #       "nix": {
  #         "formatter": {
  #           "command": ["${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"]
  #         },
  #         "language_server": {
  #           "command": ["${pkgs.nil}/bin/nil"]
  #         }
  #       },
  #       "bash": {
  #         "format_on_save": true,
  #         "language_server": {
  #           "command": ["${pkgs.bash-language-server}/bin/bash-language-server", "start"]
  #       },
  #       "odin": {
  #         "compiler": {
  #           "command": ["${pkgs.odin}/bin/odin"]
  #         }
  #         "language_server":
  #           "command": ["${pkgs.ols}/bin/ols"]
  #       }
  #     },
  #     "lsp":
  #       "pyright":

  #   }
  # '';

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

}
