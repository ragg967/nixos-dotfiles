{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ryes-nixos"; # Define your hostname.
  networking.wireless = {
    enable = true;
    networks = {
      "House" = {
        psk = "c4t3sn3t";
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
  ];

  programs.fish.enable = true;
  programs.firefox.enable = true;

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
  system.stateVersion = "25.05";
}
