{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  options.settings.console = {
    font = lib.mkOption {
      type = lib.types.str;
      default = "ter-u32n";
    };
    keyMap = lib.mkOption {
      type = lib.types.str;
      default = "no";
    };
  };

  config = with config.settings.console; {
    fonts.packages = with pkgs; [terminus_font];
    console = {
      packages = with pkgs; [terminus_font];
      font = font;
      keyMap = keyMap;
    };

    console.colors = let
      c = config.hm.colorScheme.palette;
    in [
      "${c.base00}" # black
      "${c.base08}" # red
      "${c.base0B}" # green
      "${c.base0A}" # yellow
      "${c.base0D}" # blue
      "${c.base0E}" # magenta
      "${c.base0C}" # cyan
      "${c.base05}" # gray
      "${c.base03}" # darkgray
      "${c.base08}" # lightred
      "${c.base0B}" # lightgreen
      "${c.base0A}" # lightyellow
      "${c.base0D}" # lightblue
      "${c.base0E}" # lightmagenta
      "${c.base0C}" # lightcyan
      "${c.base06}" # white
    ];
  };
}
