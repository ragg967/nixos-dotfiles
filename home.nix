{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  createSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    qtile = "qtile";
    nvim = "nvim";
		kitty="kitty";
  };
in

{
  home.username = "rye";
  home.homeDirectory = "/home/rye";
  home.stateVersion = "25.05";

  # Fish shell
  programs.fish = {
    enable = true;
    shellAliases = {
      # System
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#ryes-nixos";

      # Modern replacements
      cat = "bat";
      ls = "eza --icons";
      l = "eza -lah --icons --git";
      ll = "eza -lh --icons --git";
      tree = "eza --tree --icons";

      # Git
      lg = "lazygit";

      # System monitoring
      top = "btop";
    };

    interactiveShellInit = ''
      cat ~/nixos-dotfiles/config/fish/fox.ansi
      set fish_greeting

      # Zoxide init (smart cd)
      zoxide init fish | source

      # fzf keybindings
      fzf --fish | source
    '';
  };

programs.git = {
  enable = true;
  userName = "Ragg967";
  userEmail = "rywatson1027@gmail.com";
};

  # Bat (better cat) with Catppuccin Mocha
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Mocha";
      style = "numbers,changes,header";
    };
    themes = {
      "Catppuccin Mocha" = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "d3feec47b16a8e99eabb34cdfbaa115541d374fc";
          sha256 = "sha256-s0CHTihXlBMCKmbBBb8dUhfgOOQu9PBCQ+uviy7o47w=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
  };

  # Zoxide (smart cd)
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  # fzf (fuzzy finder) with Catppuccin Mocha colors
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
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
    defaultOptions = [
      "--height 40%"
      "--border"
      "--layout=reverse"
    ];
  };

  # Yazi file manager
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = createSymlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    # Modern CLI tools
    yazi # TUI file manager
    bat # cat replacement
    eza # ls replacement
    fd # find replacement
    ripgrep # grep replacement
    zoxide # smart cd
    fzf # fuzzy finder
    dust # disk usage
    procs # ps replacement
    btop # system monitor

    # Git tools
    lazygit
    gh

    # Development - Lua
    luajit
    luarocks
    lua-language-server

    # Development - General
    neovim
    nodejs

		# Nim
		nim
		nimble
		nimlsp

		# C
    llvm
    gcc
    clang-tools
		gnumake

    # Nix
    nil
    nixpkgs-fmt

		# Toml
    taplo

    # Python
    python314
    pyright
    ruff

    # Wayland tools
    tofi

    # Game dev
    godotPackages_4_5.godot

		# Gaming
		steam
  ];
}
