{
  myFont,
  ...
}:

{

  programs.kitty = {
    enable = true;
    # These settings are simply copied from my kitty config.
    settings = {
      # Fonts
      font_family = "${myFont}";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = "15.0";

      # Settings
      background_opacity = 0.95;
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      macos_titlebar_color = "background";
      linux_display_server = "x11";

      foreground = "#cccccc";
      background = "#1e1e1e";
      selection_foreground = "#cccccc";
      selection_background = "#264f78";
      cursor = "#ffffff";
      cursor_text_color = "#1e1e1e";
      active_border_color = "#e7e7e7";
      inactive_border_color = "#414140";
      active_tab_foreground = "#ffffff";
      active_tab_background = "#3a3d41";
      inactive_tab_foreground = "#858485";
      inactive_tab_background = "#1e1e1e";
      color0 = "#000000";
      color8 = "#666666";
      color1 = "#f14c4c";
      color9 = "#cd3131";
      color2 = "#23d18b";
      color10 = "#0dbc79";
      color3 = "#f5f543";
      color11 = "#e5e510";
      color4 = "#3b8eea";
      color12 = "#2472c8";
      color5 = "#d670d6";
      color13 = "#bc3fbc";
      color6 = "#29b8db";
      color14 = "#11a8cd";
      color7 = "#e5e5e5";
      color15 = "#e5e5e5";

    };
  };
}
