# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ./vmware-guest.nix
  ];



  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };
  
  programs.hyprland.enable = true;

  environment.systemPackages = [
    # ... other packages
    pkgs.kitty # required for the default Hyprland config
    pkgs.mesa
    pkgs.gtk3
];

  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    
    users.stringydev = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "input" ];
    };
  };

  # Set your time zone/
  time.timeZone = "Europe/London";

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # VM-Tools
  disabledModules = [ "virtualisation/vmware-guest.nix" ];
  # virtualisation.vmware.guest.enable = true;

  system.stateVersion = "24.05"; # Don't change it bro
}  
