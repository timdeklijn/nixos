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
      font_size = "14.0";

      # Settings
      background_opacity = 0.95;
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      macos_titlebar_color = "background";
      linux_display_server = "x11";

      # Colors
      background            ="#00181f";
      foreground            ="#708183";
      cursor                ="#708183";
      selection_background  ="#002731";
      color0                ="#002731";
      color8                ="#465a61";
      color1                ="#d01b24";
      color9                ="#bd3612";
      color2                ="#728905";
      color10               ="#465a61";
      color3                ="#a57705";
      color11               ="#52676f";
      color4                ="#2075c7";
      color12               ="#708183";
      color5                ="#c61b6e";
      color13               ="#5856b9";
      color6                ="#259185";
      color14               ="#81908f";
      color7                ="#e9e2cb";
      color15               ="#fcf4dc";
      selection_foreground  ="#001e26";

    };
  };
}
