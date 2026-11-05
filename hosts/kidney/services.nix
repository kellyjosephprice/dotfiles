# What the house services need from the OS. The services themselves are
# defined in ~/git/prunez-estate/docker-compose.yml.
{ config, pkgs, ... }:

let
  docker = "${config.virtualisation.docker.package}/bin/docker";
in
{
  virtualisation.docker.enable = true;

  # Home Assistant talks to BlueZ through the /run/dbus mount.
  hardware.bluetooth.enable = true;

  # NixOS has its firewall on by default, and Ubuntu here had none running.
  # These are the ports the services were listening on before migrating.
  networking.firewall = {
    allowedTCPPorts = [
      22 # SSH
      53 # Pi-hole DNS
      80 # Pi-hole web
      443 # Pi-hole web
      8001 # deCONZ web
      8123 # Home Assistant
      8443 # deCONZ websocket
      5006 # Actual Budget
      19999 # Netdata
      18555 # Home Assistant go2rtc
    ];
    allowedUDPPorts = [
      53 # Pi-hole DNS
      67 # Pi-hole DHCP
      123 # Pi-hole NTP
      1900 # Home Assistant SSDP discovery
      5353 # Home Assistant mDNS discovery
    ];
  };

  # Compose brings the containers up at boot. Their restart policies keep
  # them running after that.
  systemd.services.prunez-estate = {
    description = "House services (docker compose)";
    after = [ "docker.service" "network-online.target" ];
    wants = [ "network-online.target" ];
    requires = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];

    # Never take the house down because of a config rebuild.
    restartIfChanged = false;

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      WorkingDirectory = "/home/kelly/git/prunez-estate";
      ExecStart = "${docker} compose up -d";
      ExecStop = "${docker} compose stop";
      TimeoutStartSec = "15min";
    };
  };
}
