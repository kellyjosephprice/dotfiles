# System settings shared by every machine.
{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow more SysRq operations (e.g. Alt+SysRq+B to reboot cleanly) as
  # a recovery escape hatch if the display ever wedges again.
  boot.kernel.sysctl."kernel.sysrq" = 1;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  hardware.graphics.enable = true;

  # Nix-built apps get their OpenGL/etc RPATHs patched at build time, so they
  # never need this. Prebuilt foreign binaries (a downloaded runtime, a
  # NuGet-bundled native .so) don't get that treatment and fail to resolve
  # libGL.so.1 and friends at runtime. nix-ld is the standard shim for that.
  # Hit this with hashlink, then again with MonoGame's native dependencies.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libGL
    openal
  ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users."kelly" = {
    isNormalUser = true;
    description = "Kelly Price";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
