{ config, pkgs, inputs, lib, ... }:

{
	options.settings.terminal.neovim.enable = lib.mkOption {
		type = lib.types.bool;
		default = false;
	};

	config = lib.mkIf (config.settings.terminal.neovim.enable) {
		programs.neovim = {
			enable = true;
			defaultEditor = true;
			withNodeJs = true;
			withPython3 = true;
			withRuby = true;

			viAlias = true;
			vimAlias = true;
			vimdiffAlias = true;

			extraPackages = with pkgs; [
				# xclip
				wl-clipboard

				nodePackages.neovim
				python311Packages.pynvim

				gcc
			];
		};

		home.sessionVariables = {
			EDITOR = "nvim";
		};
	};
}
