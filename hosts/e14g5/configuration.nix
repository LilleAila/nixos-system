{
  config,
  lib,
  pkgs,
  inputs,
  globalSettings,
  outputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixosModules
  ];

  networking.hostId = "cc76db3f";

  settings = {
    greeter.enable = true;
    xserver.xwayland.enable = true;
    locale = {
      main = "en_US.UTF-8";
      other = "nb_NO.UTF-8";
      timeZone = "Europe/Oslo";
    };
    user.name = globalSettings.username;
    user.shell = pkgs.zsh;
    networking = {
      enable = true;
      hostname = "e14g5-nix";
      wifi.enable = true;
      bluetooth.enable = true;
    };
    utils.enable = true;
    desktop.enable = true;
    syncthing.enable = true;
    sound.enable = true;
    console = {
      font = "ter-u16n";
      keyMap = "no";
    };
    sops.enable = true;
    yubikey.enable = true;
    virtualisation.enable = true;

    zfs.enable = true;
    zfs.encryption = true;
    zfs.snapshots = true;
    impermanence.enable = true;
  };

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "amd_pstate=active"
  ];

  systemd.services.disable_micmute_led = {
    description = "Disabled the microphone mute light on the keyboard";
    after = ["multi-user.target"];
    script = ''
      echo 0 | tee /sys/class/leds/platform::micmute/brightness
    '';
    wantedBy = ["multi-user.target"];
  };

  services.logind.extraConfig = ''
    HandleLidSwitch=suspend
    HandleLidSwitchDocked=suspend
  '';

  services.xserver.videoDrivers = ["amdgpu"];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  nixpkgs.overlays = [
    (final: prev: {
      libfprint = prev.callPackage ../../pkgs/libfprint-fpcmoh.nix {};
    })
  ];

  services.fprintd = {
    enable = false;
  };

  # settings.nix.unfree = [
  #   # "libfprint-2-tod1-goodix-550a"
  #   # "libfprint-2-tod1-goodix"
  #   # "libfprint-2-tod1-elan"
  # ];
  #
  # services.fprintd = {
  #   enable = true;
  #   tod = {
  #     enable = true;
  #     # driver = pkgs.libfprint-2-tod1-vfs0090;
  #     # driver = pkgs.libfprint-2-tod1-goodix-550a;
  #     # driver = pkgs.libfprint-2-tod1-goodix;
  #     # driver = pkgs.libfprint-2-tod1-elan;
  #     driver = outputs.packages.${pkgs.system}.libfprint-2-tod1-fpc;
  #   };
  # };

  services.fwupd.enable = true;

  services.thermald.enable = true;

  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        turbo = "auto";
        # cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
        governor = "powersave";
        energy_performance_preference = "balance_performance";
        # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
        scaling_min_freq = 400000; # (400 mHz in kHz)
        # cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
        scaling_max_freq = 4546000; # (4546 mHz in kHz)
      };
      battery = {
        governor = "powersave";
        # For some reason, only the performance epp is available when on charger
        # cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
        energy_performance_preference = "power";
        enable_thresholds = true;
        start_threshold = 75;
        stop_threshold = 80;
        turbo = "never";
        scaling_min_freq = 400000; # (400 mHz in kHz)
        scaling_max_freq = 2000000; # (2000 mHz in kHz)
      };
    };
  };

  # i have to fix power management some time..
  services.tlp = {
    enable = false;
    settings = {
      # Values commented out are managed by auto-cpufreq instead
      # TLP is only used for GPU and disabling / enabling devices
      # Using both at the same time is not recommended, but meh what could go wrong?

      # START_CHARGE_THRESH_BAT0 = 75;
      # STOP_CHARGE_THRESH_BAT0 = 80;
      # RESTORE_THRESHOLDS_ON_BAT = 1;

      RADEON_DPM_PERF_LEVEL_ON_AC = "high";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";

      RADEON_DPM_STATE_ON_AC = "performance";
      RADEON_DPM_STATE_ON_BAT = "battery";

      RADEON_POWER_PROFILE_ON_AC = "high";
      RADEON_POWER_PROFILE_ON_BAT = "low";

      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # https://github.com/AdnanHodzic/auto-cpufreq/discussions/176
      # Loud high-pitched fan noise under load, so a bit of power is sacrificed
      # https://linrunner.de/tlp/support/optimizing.html#reduce-power-consumption-fan-noise-on-ac-power
      # CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
      # CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      # PLATFORM_PROFILE_ON_AC = "performance";
      # PLATFORM_PROFILE_ON_BAT = "low-power";
      # CPU_BOOST_ON_AC = 1;
      # CPU_BOOST_ON_BAT = 0;
      # CPU_HWP_DYN_BOOST_ON_AC = 1;
      # CPU_HWP_DYN_BOOST_ON_BAT = 0;
      # RUNTIME_PM_ON_AC = "auto";
      # RUNTIME_PM_ON_BAT = "auto";

      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_AUDIO = 1;
      WOL_DISABLE = "Y";
      WIFI_PWR_ON_AC = "on";
      WIFI_PWR_ON_BAT = "on";
      DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi";
      DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi";

      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth nfc wwan";
      DEVICES_TO_ENABLE_ON_STARTUP = "wifi";
      DEVICES_TO_DISABLE_ON_SHUTDOWN = "bluetooth nfc wifi wwan";
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth nfc wifi wwan";
    };
  };
  system.stateVersion = "24.11";
}
