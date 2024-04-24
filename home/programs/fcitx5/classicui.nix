{config, ...}: let
  c = config.colorScheme.palette;
in ''
  # Vertical Candidate List
  Vertical Candidate List=False
  # Use mouse wheel to go to prev or next page
  WheelForPaging=True
  # Font
  Font="Sans 10"
  # Menu Font
  MenuFont="Sans 10"
  # Tray Font
  TrayFont="Sans Bold 10"
  # Tray Label Outline Color
  TrayOutlineColor=#${c.base00}
  # Tray Label Text Color
  TrayTextColor=#${c.base06}
  # Prefer Text Icon
  PreferTextIcon=False
  # Show Layout Name In Icon
  ShowLayoutNameInIcon=True
  # Use input method language to display text
  UseInputMethodLanguageToDisplayText=True
  # Theme
  Theme=default
  # Dark Theme
  DarkTheme=default
  # Follow system light/dark color scheme
  UseDarkTheme=False
  # Follow system accent color if it is supported by theme and desktop
  UseAccentColor=True
  # Use Per Screen DPI on X11
  PerScreenDPI=False
  # Force font DPI on Wayland
  ForceWaylandDPI=0
  # Enable fractional scale under Wayland
  EnableFractionalScale=True
''
