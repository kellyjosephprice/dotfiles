# ThinkPad X1 Carbon 7th, always on, runs the house services.
{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ./hardware-configuration.nix
    ./services.nix
  ];

  networking.hostName = "kidney";

  # The EFI partition is shared with Ubuntu during the migration, so don't
  # let old NixOS generations fill it.
  boot.loader.systemd-boot.configurationLimit = 10;

  # Static address on the USB ethernet adapter. Pi-hole first; the router is
  # the fallback so this machine can still resolve names when Pi-hole is down.
  networking.networkmanager.ensureProfiles.profiles.lan = {
    connection = {
      id = "lan";
      type = "ethernet";
      interface-name = "enx00e04c050e9c";
      autoconnect = "true";
    };
    ipv4 = {
      method = "manual";
      address1 = "192.168.1.65/24,192.168.1.254";
      dns = "127.0.0.1;192.168.1.254;";
    };
    ipv6.method = "auto";
  };

  # Keep running with the lid closed, and never sleep. Masking the sleep
  # targets also covers the login screen, which can suspend on its own.
  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.openssh = {
    enable = true;
    # Matches Ubuntu today: passwords allowed, keyboard-interactive off.
    settings.KbdInteractiveAuthentication = false;
  };

  services.thermald.enable = true;
  services.fwupd.enable = true;

  # First boot finds files from Ubuntu in the home folder. Keep them with
  # this suffix instead of failing activation.
  home-manager.backupFileExtension = "ubuntu-bak";

  # First NixOS version installed on this machine. Don't change it after
  # install: see `man configuration.nix`, system.stateVersion.
  system.stateVersion = "26.05";
}
