# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };
 
  environment.systemPackages = with pkgs; [
    kitty
    vim
  ];

  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    
    users.stringydev = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "input" ];
      openssh.authorizedKeys.keys = [
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILsQ7imhxQZrlzUrJTQFhXbueh3klK2HPmzLUkzY6+Rf danny_bozbay@gmail.com"
      ];
    };
  };

  time.timeZone = "Europe/London";

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Trusted users
  nix.settings.trusted-users = [ "root" "stringydev" ];

  # VM-Tools
  virtualisation.vmware.guest.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];

  system.stateVersion = "24.05"; # Don't change it bro
}  

