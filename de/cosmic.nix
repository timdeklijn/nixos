{config, pkgs, ...}:
{
  # Enable the Cosmic desktop manager
  services.desktopManager.cosmic.enable = true;

  # Add any other necessary packages
  # environment.systemPackages = with pkgs; [
  #   # Add Cosmic packages and other applications here
  # ];

  # Example: Configure the COSMIC_DATA_CONTROL_ENABLED environment variable
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;

  # Example: Configure Firefox to disable libadwaita theming
  programs.firefox.preferences = {
    "widget.gtk.libadwaita-colors.enabled" = false;
  };

}
