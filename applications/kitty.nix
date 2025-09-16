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

      foreground = "#adbac7";
      background = "#22272e";
      selection_foreground = "#22272e";
      selection_background = "#539bf5";
      cursor = "#539bf5";
      tab_bar_background = "#1c2128";
      active_tab_foreground = "#adbac7";
      active_tab_background = "#22272e";
      inactive_tab_foreground = "#768390";
      inactive_tab_background = "#1c2128";
      color0 = "#545d68";
      color8 = "#636e7b";
      color1 = "#f47067";
      color9 = "#ff938a";
      color2 = "#57ab5a";
      color10 = "#6bc46d";
      color3 = "#c69026";
      color11 = "#daaa3f";
      color4 = "#539bf5";
      color12 = "#6cb6ff";
      color5 = "#b083f0";
      color13 = "#dcbdfb";
      color6 = "#39c5cf";
      color14 = "#56d4dd";
      color7 = "#909dab";
      color15 = "#cdd9e5";
    };
  };
}
