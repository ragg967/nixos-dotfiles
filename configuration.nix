{ config, lib, pkgs, ... }:

let
  secrets = import ./secrets.nix;
in

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ryes-nixos";
  networking.wireless = {
    enable = true;
    networks = {
      "${secrets.wifiName1}" = {
        psk = secrets.wifiPassword1;
      };
      "${secrets.wifiName2}" = {
        psk = secrets.wifiPassword2;
      };
    };
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
  };
  services.displayManager.ly.enable = true;

  services.libinput.enable = true;

  users.users.rye = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      tree
    ];
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
    "aseprite"
  ];

  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;

  #
  # Audio
  #
  services.pulseaudio.enable = false; # Use Pipewire, the modern sound subsystem

  security.rtkit.enable = true; # Enable RealtimeKit for audio purposes

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Uncomment the following line if you want to use JACK applications
    # jack.enable = true;
  };


  services.upower = {
    enable = true;
    percentageLow = 20;
    percentageCritical = 10;
    percentageAction = 5;
    criticalPowerAction = "Hibernate"; # or "PowerOff"
  };

  #
  # Bluetooth
  #
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty
    git
    wl-clipboard
  ];

  fonts = {
    packages = with pkgs; [
      maple-mono.NF
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Maple Mono NF" ];
        sansSerif = [ "Maple Mono NF" ];
        serif = [ "Maple Mono NF" ];
      };
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";
}
