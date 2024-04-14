# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;
  boot.initrd.luks.devices."luks-88c6adff-e723-48ab-8595-5a0b7975f623".device = "/dev/disk/by-uuid/88c6adff-e723-48ab-8595-5a0b7975f623";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.logind.extraConfig =
    /*
    conf
    */
    ''
      HandlePowerKey=ignore
    '';

  services.upower.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
      # Recalibrate with `tlp fullcharge/recalibrate`.
      # This restores charge threshold before reboot:
      RESTORE_THRESHOLDS_ON_BAT = 1;
    };
  };
  # services.auto-cpufreq = {
  # 	enable = true;
  # };

  # https://github.com/NixOS/nixos-hardware
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    # LIBVA_DRIVER_NAME = "iHD";
    # LIBVA_DRIVER_NAME = "i965"; # <- This one works on T420
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };

  security.pam.services.swaylock = {
    # enable = true;
    # fprintAuth = true;
  };
  # services.fprintd = {
  # 	enable = true;
  # 	tod = {
  # 		enable = true;
  # 		driver = pkgs.libfprint-2-tod1-elan;
  # 	};
  # };

  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    configPackages = [pkgs.xdg-desktop-portal-gtk];
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland";
      };
    };
    vt = 2;
  };

  programs.dconf.enable = true;

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "no";
    xkb.variant = "";

    updateDbusEnvironment = true;
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
      };
    };
    enableCtrlAltBackspace = true;

    # windowManager.exwm = {
    # 	enable = true;
    # };

    # displayManager = {
    # 	# defaultSession = "hyprland";
    # 	lightdm = {
    # 		enable = true;
    # 		greeters.mini = {
    # 			enable = true;
    # 		};
    # 	};
    # };

    displayManager.lightdm.enable = true;
  };
  programs.xwayland = {
    enable = true;
  };

  # Configure console keymap
  console.keyMap = "no";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.olai = {
    isNormalUser = true;
    description = "Olai";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  environment.shells = [pkgs.zsh];
  programs.zsh.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # services.openssh.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    curl
    neovim
    vim
    home-manager
  ];

  services.fwupd.enable = true;

  # Enable steam
  programs.steam = {
    enable = true;
    package = pkgs.steam;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
