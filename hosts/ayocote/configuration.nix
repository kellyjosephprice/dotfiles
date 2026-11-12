# Dev machine.
{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ./hardware-configuration.nix
  ];

  # Workaround for amdgpu DMCUB display-firmware hangs on resume from
  # suspend (seen as "flip_done timed out" freezes on this Phoenix iGPU).
  # Disables Panel Self-Refresh, which is the common trigger.
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];

  networking.hostName = "ayocote";

  # kidney's Samba share. Mounted lazily (only on first access, and only
  # if reachable) so a rebuild or boot never hangs waiting on it. Uses
  # kidney's Tailscale name rather than its LAN IP, so this works the same
  # whether you're home or away, as long as Tailscale is connected.
  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/home/kelly/mnt/prunez-estate" = {
    device = "//kidney.dinosaur-aldebaran.ts.net/prunez-estate";
    fsType = "cifs";
    options = [
      "credentials=/etc/samba-creds-kidney"
      "uid=1000"
      "gid=100"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "_netdev"
    ];
  };

  # First NixOS version installed on this machine. Don't change it after
  # install: see `man configuration.nix`, system.stateVersion.
  system.stateVersion = "26.05";
}
