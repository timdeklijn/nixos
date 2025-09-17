{
  pkgs,
  myFont,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        charliermarsh.ruff
        dracula-theme.theme-dracula
        elixir-lsp.vscode-elixir-ls
        jnoortheen.nix-ide
        johnpapa.vscode-peacock
        tal7aouy.icons
        mechatroner.rainbow-csv
        ms-azuretools.vscode-docker
        ms-python.black-formatter
        ms-python.debugpy
        ms-python.isort
        ms-python.pylint
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        ms-vscode-remote.remote-containers
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-ssh-edit
        myriad-dreamin.tinymist
        nefrob.vscode-just-syntax
        redhat.vscode-yaml
        rust-lang.rust-analyzer
        sainnhe.gruvbox-material
        tamasfe.even-better-toml
      ];
      userSettings = {
        "editor.fontFamily" = "'${myFont}', monospace";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 14;
        "editor.lineHeight" = 1.3;
        "editor.fontWeight" = "500";
        "editor.lineNumbers" = "off";
        "editor.minimap.enabled" = false;
        "editor.minimap.autohide" = "none";
        "editor.inlayHints.enabled" = "offUnlessPressed";
        "editor.formatOnSave" = true;
        "editor.scrollbar.vertical" = "hidden";
        "editor.semanticHighlighting.enabled" = true;
        "editor.scrollbar.horizontal" = "hidden";
        "editor.glyphMargin" = true;
        "editor.folding" = false;
        "debug.console.fontFamily" = "'${myFont}', monospace";
        "debug.console.fontSize" = 14;
        "terminal.integrated.fontFamily" = "'${myFont}', monospace";
        "terminal.integrated.fontSize" = 14;
        "terminal.integrated.fontWeight" = "500";
        "terminal.integrated.tabs.location" = "left";
        "terminal.integrated.enableMultiLinePasteWarning" = "never";
        "workbench.startupEditor" = "none";
        "workbench.sideBar.location" = "right";
        "workbench.activityBar.location" = "bottom";
        "workbench.editor.showTabs" = "none";
        "workbench.secondarySideBar.defaultVisibility" = "hidden";
        "window.menuBarVisibility" = "toggle";
        "window.customTitleBarVisibility" = "auto";
        "window.zoomLevel" = 1.5;
        "explorer.confirmDelete" = false;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "diffEditor.maxComputationTime" = 0;
        "chat.commandCenter.enabled" = false;
        "[python]"."editor.defaultFormatter" = "charliermarsh.ruff";
        "[restructuredtext]"."editor.wordWrap" = "on";
        "[markdown]"."files.trimTrailingWhitespace" = true;
        "[markdown]"."editor.wordWrapColumn" = 100;
        "[markdown]"."editor.wordWrap" = "wordWrapColumn";
        "python.analysis.typeCheckingMode" = "standard";
        "redhat.telemetry.enabled" = false;
        "git.decorations.enabled" = true;
        "remote.autoForwardPortsSource" = "hybrid";
        "workbench.colorTheme" = "Dracula Theme";
        "workbench.iconTheme" = "vs-seti";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings.nixd.nixpkgs.expr" =
          "import (builtins.getFlake \"/path/to/flake.nix\").inputs.nixpkgs {}";
        "nix.serverSettings.options.home_manager.expr" =
          "(builtins.getFlake \"/path/to/flake.nix\").nixosConfigurations.<name>.options.home-manager.users.type.getSubOptions []";
        "nix.serverSettings.options.nixos.expr" =
          "(builtins.getFlake \"/path/to/flake.nix\").nixosConfigurations.<name>.options";
        "terminal.integrated.shellIntegration.enabled" = false;
      };
      keybindings = [
        {
          key = "ctrl+k T T";
          command = "testing.reRunLastRun";
        }
        {
          key = "ctrl+k T A";
          command = "testing.runAll";
        }
        {
          key = "ctrl+k T C";
          command = "testing.runAtCursor";
        }
        {
          key = "ctrl+k T D";
          command = "testing.debugAtCursor";
        }
      ];
    };
  };
}
