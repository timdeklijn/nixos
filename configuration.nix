{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    <nixos-hardware/framework/13-inch/7040-amd> # Framework specific hardware drivers
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "fw13"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver = {
    videoDrivers = [
      "displaylink"
      "modesetting"
    ];
    enable = true;
  };

  environment.variables = {
    KWIN_DRM_PREFER_COLOR_DEPTH = "24";
  };

  # Use KDE Plasma as desktop environment
  services = {
    desktopManager.plasma6 = {
      enable = true;
    };
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "plasma";
    };

  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.fprintd.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tim = {
    isNormalUser = true;
    description = "Tim de Klijn";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    # user packages
    packages = with pkgs; [
      # command lin utilities
      direnv
      eza
      fzf
      git
      git-lfs
      just
      kitty
      nixfmt-rfc-style
      ripgrep
      starship
      tmux
      vim
      wget
      zoxide

      # 'GUI' programs
      citrix_workspace
      dropbox
      obsidian
      signal-desktop
      slack
      spotify
      vscode-fhs
    ];
    # Set default shell
    shell = pkgs.zsh;
  };

  # download nerd fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.geist-mono
  ];

  # use 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "tim" ];
  };

  # Configure shell tools
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
  };
  programs.starship.enable = true;
  programs.firefox.enable = true;

  # Global packages
  environment.systemPackages = with pkgs; [
    # Follow this:
    # https://wiki.nixos.org/wiki/Displaylink
    # there is a manual step to download the package in there.
    displaylink
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Docker should work, and there should be an ssh-agent active that forwards
  # the hosts ssh credentials.
  virtualisation.docker = {
    enable = true;
    extraPackages = [ pkgs.openssh ];
  };
  programs.ssh.startAgent = true;

  # This is required to get the right drivers fro my framework laptop
  services.fwupd.enable = true;
  hardware.framework.amd-7040.preventWakeOnAC = true;

  # remove old generations
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
