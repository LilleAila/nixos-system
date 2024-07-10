{
  config,
  lib,
  pkgs,
  inputs,
  globalSettings,
  keys,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../nixosModules
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostId = "210c2d42";

  settings = {
    greeter.enable = true;
    xserver.xwayland.enable = true;
    utils.enable = true;
    desktop.enable = true;
    sound.enable = true;
    yubikey.enable = true;
    syncthing.enable = true;

    locale = {
      main = "en_US.UTF-8";
      other = "nb_NO.UTF-8";
      timeZone = "Europe/Oslo";
    };
    user.name = globalSettings.username;
    networking = {
      enable = true;
      hostname = "x220-nix";
      wifi.enable = true;
      bluetooth.enable = true;
    };
    console = {
      font = "ter-u16n";
      keyMap = "no";
    };
    sops.enable = true;
    gpg.enable = true;

    ssh.enable = true;
    ssh.keys = with keys.ssh; [
      mac.public
      legion.public
      e14g5.public
      t420.public
    ];

    zfs.enable = true;
    zfs.encryption = true;
    zfs.snapshots = true;
    impermanence.enable = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;
      # Recalibrate with `tlp fullcharge/recalibrate`.
      # This restores charge threshold before reboot:
      RESTORE_THRESHOLDS_ON_BAT = 1;

      # Optimize for power on battery and performance on AC
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      # MEM_SLEEP_ON_AC = "s2idle";
      # MEM_SLEEP_ON_BAT = "deep";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;
      # CPU_DRIVER_OPMODE_ON_AC = "active";
      # CPU_DRIVER_OPMODE_ON_BAT = "passive";
      # CPU_SCALING_GOVERNOR_ON_AC = "performance";
      # CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "default"; # default or powersave
      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_AUDIO = 1; # Exclude audio from autosuspend
      # USB_AUTOSUSPEND_DISABLE_ON_SHUTDOWN = 1;

      INTEL_GPU_MIN_FREQ_ON_AC = 650;
      INTEL_GPU_MAX_FREQ_ON_AC = 1300;
      INTEL_GPU_BOOST_FREQ_ON_AC = 1300;
      INTEL_GPU_MIN_FREQ_ON_BAT = 650;
      INTEL_GPU_MAX_FREQ_ON_BAT = 1000;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 1000;

      # Radio and netowrk stuff
      WOL_DISABLE = "Y"; # wake-on-lan
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
      DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi";
      DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi";
    };
  };

  system.stateVersion = "24.11";
}
