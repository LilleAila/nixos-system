{ lib, config, ... }:

let
	inherit (lib) mkOption types;
in
{
	options.settings.monitors = mkOption {
		type = types.listOf (types.submodule {
			options = {
				name = mkOption {
					type = types.str;
					example = "eDP-1";
				};
				width = mkOption {
					type = types.int;
					example = 1920;
				};
				height = mkOption {
					type = types.int;
					default = 1080;
				};
				refreshRate = mkOption {
					type = types.int;
					default = 60;
				};
				x = mkOption {
					type = types.int;
					default = 0;
				};
				y = mkOption {
					type = types.int;
					default = 0;
				};
				scale = mkOption {
					type = types.int;
					default = 1;
				};
				enable = mkOption {
					type = types.bool;
					default = true;
				};
				wallpaper = mkOption {
					type = types.path;
					default = null;
				};
			};
		});
		default = [ ];
		description = ''
		Monitor configuration for hyprland
		'';
	};

	config = {
		wayland.windowManager.hyprland.settings.monitor = map
			(m:
				let
					resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
					position = "${toString m.x}x${toString m.y}";
					scale = "${toString m.scale}";
				in
				"${m.name},${if m.enable then "${resolution},${position},${scale}" else "disable"}"
			)
			(config.settings.monitors);
	};
}
