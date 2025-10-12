{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    <nixos-hardware/framework/13-inch/7040-amd> # Framework specific hardware drivers
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Help with instability in wifi and OS
  hardware.enableRedistributableFirmware = true;
  hardware.firmware = [ pkgs.linux-firmware ];

  # Keyboard config
  hardware.keyboard.uhk.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Help with instability in wifi and OS
  #
  # NOTE: somehow this did not work with linux kernel version 6.17 and
  # 'displaylink'
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "amdgpu.dcdebugmask=0x10"
  ];
  services.power-profiles-daemon.enable = true;

  networking.hostName = "fw13"; # Define your hostname.
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
      "amd"
      "displaylink"
      "modesetting"
    ];
    enable = true;
  };

  boot = {
    extraModulePackages = [ config.boot.kernelPackages.evdi ];
    initrd = {
      kernelModules = [
        "evdi"
      ];
    };
  };

  # should help freezing on startup
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    amdvlk # Or another vulkan driver like radeon-vulkan
    mesa
  ];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.flatpak = {
    enable = true;
    packages = [
      "com.dropbox.Client"
      "org.signal.Signal"
      "app.zen_browser.zen"
    ];
  };

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
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

  programs.nix-ld.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tim = {
    isNormalUser = true;
    description = "Tim de Klijn";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    # Set default shell
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  # download nerd fonts
  fonts.packages = with pkgs; [
    nerd-fonts.ubuntu-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.comic-shanns-mono
    nerd-fonts.caskaydia-mono
    nerd-fonts.geist-mono
    nerd-fonts.hasklug
    nerd-fonts.sauce-code-pro
  ];

  # use 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "tim" ];
  };
  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
    "openssl-1.1.1w"
  ];

  # Global packages
  environment.systemPackages = with pkgs; [
    # Follow this:
    # https://wiki.nixos.org/wiki/Displaylink
    # there is a manual step to download the package in there.
    displaylink
    qmk
    uhk-agent
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Docker should work, and there should be an ssh-agent active that forwards
  # the hosts ssh credentials.
  virtualisation.docker = {
    enable = true;
    extraPackages = [ pkgs.openssh ];
  };
  # programs.ssh.startAgent = true;

  # This is required to get the right drivers fro my framework laptop
  services.fwupd.enable = true;
  hardware.framework.amd-7040.preventWakeOnAC = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

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
