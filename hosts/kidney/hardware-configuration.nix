# Written by hand before install, because the NixOS partition doesn't exist
# yet. Compare with `nixos-generate-config --show-hardware-config` at install
# time and update it if anything differs.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "thunderbolt" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];

  # Partition created and labeled in the migration's "make room" step.
  fileSystems."/" = {
    device = "/dev/disk/by-label/kidney-nixos";
    fsType = "ext4";
  };

  # Existing EFI partition, shared with Ubuntu.
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9605-760F";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
