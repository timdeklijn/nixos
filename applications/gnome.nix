# Add these GNOME packages to the home manager packages.
# gnome-shell-extensions
# gnome-tweaks
# gnomeExtensions.appindicator
# gnomeExtensions.dash-to-panel
# gnomeExtensions.focus-follows-workspace
# gnomeExtensions.search-light
# gnomeExtensions.vitals
# gnomeExtensions.open-bar


{
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        # plugins
        "Vitals@CoreCoding.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "search-light@icedman.org"
        "focus-follows-workspace@christopher.luebbemeier.gmail.com"
        "openbar@neuromorph"
        "nightthemeswitcher@romainvigier.fr"
      ];
    };
    "org/gnome/desktop/default-applications/browser" = {
      # Zen (flatpak) is my default browser
      exec = "google-chrome-stable";
      name = "Google Chrome";
    };
    "org/gnome/shell/extensions/nightthemeswitcher" = {
      enabled = true;
      # Options: "manual", "sunrise-sunset", "location", etc.
      schedule = "sunrise-sunset";
      themes = true;
      gtk-theme-dark = "Adwaita-dark";
      gtk-theme-light = "Adwaita";
      wallpaper = false;
      shell = true;
      shell-theme-dark = "Adwaita-dark";
      shell-theme-light = "Adwaita";
      notifications = true;
    };
    # (Optional) Notification settings
    "org/gnome/settings-daemon/plugins/power" = {
      ambient-enabled = false;
    };
    "org/gnome/mutter" = {
      # disable dynamic workspaces
      dynamic-workspaces = false;
      # set fixed number of workspaces
      num-workspaces = 4;
      experimental-features = [ "scale-monitor-framebuffer" ];
      # Only have workspaces on the primary monitors
      workspaces-only-on-primary = true;
    };
    "org/gnome/shell/keybindings" = {
      # Reset super+num keymaps
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      switch-to-application-5 = [ ];
      switch-to-application-6 = [ ];
      switch-to-application-7 = [ ];
      switch-to-application-8 = [ ];
      switch-to-application-9 = [ ];
      switch-to-application-10 = [ ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      # Set super+num and super+shift+num keymaps to navigate desktops
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];

      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      icon-theme = "Adwaita";
      cursor-theme = "Adwaita";
      clock-format = "24h";
      clock-show-weekday = true;
      enable-animations = true;
      text-scaling-factor = 1.0;
      enable-hot-corners = false;
      show-battery-percentage = true;
    };
    "org/gnome/shell/extensions/open-bar" = {
      "bar-type" = 2;
      "neon-glow" = false;
      "bar-margins" = 0;
    };
    "org/gnome/desktop/sound" = {
      event-sounds = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "google-chrome-stable" ];
      "x-scheme-handler/http" = [ "google-chrome-stable" ];
      "x-scheme-handler/https" = [ "google-chrome-stable" ];
    };
  };
}
