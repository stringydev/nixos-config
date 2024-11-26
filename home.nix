{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "stringydev";
  home.homeDirectory = "/home/stringydev";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  xdg.configFile = {
    "i3/config".text = builtins.readFile ./i3;
    "ghostty/config".text = builtins.readFile ./ghostty;
    "kitty/kitty.conf".text = builtins.readFile ./kitty;
  };


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # utils
    ripgrep # recursively searches directories for a regex pattern
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    fd
    lazygit
    
    # python
    uv # A package manager

  ];

  # Hyprland
  # wayland.windowManager.hyprland = {
  # enable = true;
  # extraConfig = builtins.readFile ./hyprland;
  # };


  # Kitty
  programs.kitty = {
    enable = true;
  };


  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "stringydev";
    userEmail = "107803920+stringydev@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      line_break.disabled = true;
    };
  };

  # neovim - the GOAT editor bro
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      rose-pine
      telescope-nvim
    ];
    extraLuaConfig = 
      ''
        vim.g.mapleader = " "
	vim.opt.number = true
	vim.opt.relativenumber = true
	vim.termguicolors = true
      '';
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      font = {
        size = 22;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # TODO add your custom bashrc here
    # bashrcExtra = ''
    #  export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    # '';

    shellAliases = 
      let 
        flakeDir = "~/nix";
      in {

      nix-rb = "sudo nixos-rebuild switch --flake ${flakeDir}";

      nix-conf = "nvim ${flakeDir}/configuration.nix";
      nix-home = "nvim ${flakeDir}/home.nix";
      nix-flake = "nvim ${flakeDir}/flake.nix";

      ll = "ls -l";
      lla = "ll --all";
      nv = "nvim";

      lg = "lazygit";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
