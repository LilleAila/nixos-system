{ config, pkgs, inputs, lib, ... }:

{
	options.settings.browser.firefox.enable = lib.mkOption {
		type = lib.types.bool;
		default = false;
	};

	config = let
		search = {
			default = "DuckDuckGo";
			engines = {
				"Nix Packages" = {
					urls = [{
						template = "https://search.nixos.org/packages?channel=unstable";
						params = [
							{ name = "type"; value = "packages"; }
							{ name = "query"; value = "{searchTerms}"; }
						];
					}];

					icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
					definedAliases = [ "@np" ];
				};

				"Nix Options" = {
					urls = [{
						template = "https://search.nixos.org/options?channel=unstable";
						params = [
							{ name = "type"; value = "options"; }
							{ name = "query"; value = "{searchTerms}"; }
						];
					}];

					icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
					definedAliases = [ "@no" ];
				};

				"Home-Manager Options" = {
					urls = [{
						# template = "https://mipmip.github.io/home-manager-option-search";
						# home-manager option search was moved to:
						template = "https://home-manager-options.extranix.com";
						params = [
							{ name = "query"; value = "{searchTerms}"; }
						];
					}];

					icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
					definedAliases = [ "@hm" ];
				};
			};
			force = true;
		};

		# Settings are stored in ~/.mozilla/firefox/profile_name/prefs.js
		# To find the name of a setting, either use `diff old_settings new_settings`
		# Or check which value changes in about:config when setting it in about:preferences
		settings = {
			"browser.startup.page" = 3; # Restore pages on startup
			"media.hardware-video-decoding.force-enabled" = true;
			"layers.acceleration.force-enabled" = true;

			"browser.toolbars.bookmarks.visibility" = "always";
			"browser.disableResetPrompt" = true;
			"browser.download.panel.shown" = true;
			"browser.download.useDownloadDir" = false;
			"browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
			"browser.startup.homepage" = "https://start.duckduckgo.com";
			"dom.security.https_only_mode" = true;
			"identity.fxaccounts.enabled" = false;
			"privacy.trackingprotection.enabled" = true;
			"signon.rememberSignons" = false;
			"browser.shell.checkDefaultBrowser" = false;
			"browser.shell.defaultBrowserCheckCount" = 1;
			"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
			"browser.startup.homepage_override.mstone" = "ignore";

			"browser.tabs.firefox-view" = false;
			"browser.tabs.tabmanager.enabled" = false;
		};

		# All available extensions:
		# https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/addons.json?ref_type=heads
		extensions = with inputs.firefox-addons.packages."${pkgs.system}"; [
			ublock-origin
			sponsorblock
			darkreader
			youtube-shorts-block
			enhanced-h264ify
		];
	in lib.mkIf (config.settings.browser.firefox.enable) {
		programs.firefox = {
			enable = true;
			profiles.main = {
				inherit settings;
				inherit search;
				inherit extensions;
				isDefault = true;
				id = 0;

				bookmarks = [
					{
						name = "Wikipedia";
						tags = [ "wiki" ];
						keyword = "wiki";
						url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
					}
					{
						name = "Toolbar";
						toolbar = true;
						bookmarks = [
							{
								name = "NixOS";
								url = "https://nixos.org";
							}
							{
								name = "NixOS wiki";
								tags = [ "wiki" "nix" ];
								url = "https://nixos.wiki/";
							}
						];
					}
				];
			};

			profiles.school = {
				inherit settings;
				inherit search;
				inherit extensions;
				id = 1;
				bookmarks = [{
					name = "Toolbar";
					toolbar = true;
					bookmarks = [
						{ name = "Classroom"; url = "https://classroom.google.com"; }
						{ name = "Docs"; url = "https://docs.google.com"; }
						{ name = "Slides"; url = "https://slides.google.com"; }
						{ name = "Sheets"; url = "https://sheets.google.com"; }
					];
				}];
			};

			profiles.math = {
				inherit settings;
				inherit search;
				inherit extensions;
				id = 2;
				bookmarks = [{
					name = "Toolbar";
					toolbar = true;
					bookmarks = [
						{ name = "Digilær"; url = "https://skole.digilaer.no"; }
						{ name = "GeoGebra"; url = "https://geogebra.org/classic"; }
						{ name = "Symbolab"; url = "https://symbolab.com"; }
					];
				}];
			};
		};

		xdg.mimeApps.defaultApplications = {
			"text/html" = [ "firefox.desktop" ];
			"text/xml" = [ "firefox.desktop" ];
			"x-scheme-handler/http" = [ "firefox.desktop" ];
			"x-scheme-handler/https" = [ "firefox.desktop" ];
		};
	};
}
