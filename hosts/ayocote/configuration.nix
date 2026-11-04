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

  # First NixOS version installed on this machine. Don't change it after
  # install: see `man configuration.nix`, system.stateVersion.
  system.stateVersion = "26.05";
}
