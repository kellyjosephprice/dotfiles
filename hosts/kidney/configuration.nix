# ThinkPad X1 Carbon 7th, always on, runs the house services.
{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ./hardware-configuration.nix
    ./services.nix
  ];

  networking.hostName = "kidney";

  # Same access as on Ubuntu. Docker group membership is effectively root.
  users.users."kelly".extraGroups = [ "docker" ];

  # The EFI partition is shared with Ubuntu during the migration, so don't
  # let old NixOS generations fill it.
  boot.loader.systemd-boot.configurationLimit = 10;

  # Static address on the USB ethernet adapter. Pi-hole first; the router is
  # the fallback so this machine can still resolve names when Pi-hole is down.
  # Matched by MAC because the adapter's name differs between distros: the enx
  # name came from a rule Ubuntu ships and NixOS doesn't.
  networking.networkmanager.ensureProfiles.profiles.lan = {
    connection = {
      id = "lan";
      type = "ethernet";
      autoconnect = "true";
    };
    ethernet.mac-address = "00:E0:4C:05:0E:9C";
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

  # A systemd-managed ssh-agent, independent of any desktop login. kidney
  # runs with no one logged into the GUI, so GNOME's own agent (the default
  # on this shared desktop config) never starts here otherwise.
  programs.ssh.startAgent = true;
  services.gnome.gcr-ssh-agent.enable = false;

  services.openssh = {
    enable = true;
    # Key-only. Authorized keys already cover normal logins (kelly@rio-zape,
    # kelly@nixos) — password auth was just an unused fallback.
    settings.KbdInteractiveAuthentication = false;
    settings.PasswordAuthentication = false;
  };

  services.thermald.enable = true;
  services.fwupd.enable = true;

  # Remote access without exposing anything to the internet, and lets
  # kidney act as an exit node for phones/laptops when they want home's
  # network (and Pi-hole's ad-blocking) while out. Joining the tailnet and
  # requesting exit-node status still needs `sudo tailscale up
  # --advertise-exit-node` by hand once.
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
  # Tailscale authenticates and encrypts its own traffic, so trust it like
  # a VPN interface rather than filtering it port-by-port.
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  # Nightly encrypted backup of the house data to Google Drive. restic does
  # the encryption and dedup; rclone is how it talks to Drive. The repo
  # password lives in ~/.config/kidney-backup/restic-password (not in this
  # repo), and rclone's own Drive login lives in ~/.config/rclone/rclone.conf
  # — both are set up by hand on kidney, not managed here.
  environment.systemPackages = with pkgs; [ restic rclone ];

  systemd.services.kidney-backup = {
    description = "Encrypted backup of house data to Google Drive";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    path = [ pkgs.restic pkgs.rclone ];
    environment = {
      RESTIC_REPOSITORY = "rclone:gdrive:kidney-backups";
      RESTIC_PASSWORD_FILE = "/home/kelly/.config/kidney-backup/restic-password";
    };
    serviceConfig = {
      Type = "oneshot";
      User = "kelly";
      # Home Assistant's auth DB and Cloud credentials are root-only (600).
      # This lets the backup read any file without needing full root.
      AmbientCapabilities = [ "CAP_DAC_READ_SEARCH" ];
      CapabilityBoundingSet = [ "CAP_DAC_READ_SEARCH" ];
      ExecStart = pkgs.writeShellScript "kidney-backup" ''
        set -euo pipefail
        restic backup \
          /opt/prunez-estate \
          /opt/deconz \
          /opt/etc-pihole \
          /opt/actual \
          /home/kelly \
          --exclude="/home/kelly/.cache" \
          --exclude="*/.cache" \
          --exclude="/home/kelly/.local/share/Trash"
        restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune
      '';
    };
  };

  systemd.timers.kidney-backup = {
    description = "Run kidney-backup nightly";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "03:00";
      Persistent = true;
    };
  };

  # First boot finds files from Ubuntu in the home folder. Keep them with
  # this suffix instead of failing activation.
  home-manager.backupFileExtension = "ubuntu-bak";

  # First NixOS version installed on this machine. Don't change it after
  # install: see `man configuration.nix`, system.stateVersion.
  system.stateVersion = "26.05";
}
