{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Dotfiles to symlink into ~/.config
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    kitty = "kitty";
    yazi = "yazi";
    tofi = "tofi";
  };

in
{
  home.username = "rye";
  home.homeDirectory = "/home/rye";
  home.stateVersion = "25.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  #
  # ------------------------------------------------------------------------------------------------
  # Shell: Fish
  # ------------------------------------------------------------------------------------------------
  #
  programs.fish = {
    enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#ryes-nixos";

      # Modern replacements
      cat = "bat";
      ls = "eza --icons";
      l = "eza -lah --icons --git";
      ll = "eza -lh --icons --git";
      tree = "eza --tree --icons";

      # Git
      lg = "lazygit";

      # Monitoring
      top = "btop";

      # flake starter
      snowflake = "cp -r ~/Templates/flake/. .";
    };

    interactiveShellInit = ''
      cat ~/nixos-dotfiles/config/fish/fox.ansi
      set fish_greeting

      # Zoxide & fzf integration
      zoxide init fish | source
      fzf --fish | source
    '';
  };

  #
  # ------------------------------------------------------------------------------------------------
  # Git
  # ------------------------------------------------------------------------------------------------
  #
  programs.git = {
    enable = true;
    userName = "Ragg967";
    userEmail = "rywatson1027@gmail.com";
  };

  #
  # ------------------------------------------------------------------------------------------------
  # Bat
  # ------------------------------------------------------------------------------------------------
  #
  programs.bat = {
    enable = true;

    config = {
      style = "numbers,changes,header";
    };
  };

  #
  # ------------------------------------------------------------------------------------------------
  # Other
  # ------------------------------------------------------------------------------------------------
  #
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";

    defaultOptions = [
      "--height 40%"
      "--border"
      "--layout=reverse"
    ];
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  #
  # ------------------------------------------------------------------------------------------------
  # Dotfile Symlinks
  # ------------------------------------------------------------------------------------------------
  #
  xdg.configFile =
    builtins.mapAttrs
      (_: subpath: {
        source = createSymlink "${dotfiles}/${subpath}";
        recursive = true;
      })
      configs;

  #
  # ------------------------------------------------------------------------------------------------
  # Packages
  # ------------------------------------------------------------------------------------------------
  #
  home.packages = with pkgs; [
    # ------ System -----
    pavucontrol # PulseAudio Volume Control
    pamixer # Command-line mixer for PulseAudio
    bluez # Bluetooth support
    bluez-tools # Bluetooth tools
    upower
    calcurse
    duf

    # ----- Fetches -----
    fastfetchMinimal
    cpufetch
    gpufetch

    # ------ CLI tools ------
    yazi
    bat
    eza
    fd
    ripgrep
    zoxide
    fzf
    dust
    procs
    btop
    wl-clipboard
    slurp
    grim

    # ------ Git tools ------
    lazygit
    gh
    git-crypt

    # ----- Neovim -----
    luajit
    gcc
    neovim
    nil
    nixpkgs-fmt

    # ------ Wayland ------
    tofi

    # ------ Game Dev ------
    godotPackages_4_5.godot

    # ------ Gaming ------
    steam
  ];

}
