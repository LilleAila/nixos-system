{ config, pkgs, lib, inputs, ... }:

{
	options.settings = {
		wm.hyprpaper.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
		};
	};

	imports = [
		inputs.hyprpaper.homeManagerModules.hyprpaper
	];

	config = lib.mkIf (config.settings.wm.hyprpaper.enable) {
		services.hyprpaper = {
			enable = true;
			splash = false;
			ipc = true;

			preloads = map (m: "${toString m.wallpaper}") (config.settings.monitors);
			wallpapers = map (m: "${toString m.name}, ${toString m.wallpaper}") (config.settings.monitors);
		};
	};
}
