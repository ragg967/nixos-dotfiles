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
  # Bat (with Catppuccin Mocha Theme)
  # ------------------------------------------------------------------------------------------------
  #
  programs.bat = {
    enable = true;

    config = {
      theme = "Catppuccin Mocha";
      style = "numbers,changes,header";
    };

    themes."Catppuccin Mocha" = {
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "d3feec47b16a8e99eabb34cdfbaa115541d374fc";
        sha256 = "sha256-s0CHTihXlBMCKmbBBb8dUhfgOOQu9PBCQ+uviy7o47w=";
      };
      file = "themes/Catppuccin Mocha.tmTheme";
    };
  };

  #
  # ------------------------------------------------------------------------------------------------
  # Zoxide / FZF / Yazi
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

    colors = {
      bg = "#1e1e2e";
      "bg+" = "#313244";
      fg = "#cdd6f4";
      "fg+" = "#cdd6f4";
      header = "#f38ba8";
      hl = "#f38ba8";
      "hl+" = "#f38ba8";
      info = "#cba6f7";
      marker = "#f5e0dc";
      pointer = "#f5e0dc";
      prompt = "#cba6f7";
      spinner = "#f5e0dc";
    };
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
