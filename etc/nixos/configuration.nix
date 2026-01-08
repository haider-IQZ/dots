{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  networking.hostName = "haider"; 

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
   time.timeZone = "Asia/Baghdad";

    # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  nixpkgs.config.allowUnfree = true;
 

#______________________________________________________________________________________
#polkit stuff
security.polkit.enable = true;
systemd.user.services.polkit-gnome-authentication-agent-1 = {                         
  description = "polkit-gnome-authentication-agent-1";
  wantedBy = [ "graphical-session.target" ];
  wants = [ "graphical-session.target" ];
  after = [ "graphical-session.target" ];
  serviceConfig = {
    Type = "simple";
    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Restart = "on-failure";
    RestartSec = 1;
    TimeoutStopSec = 10;
  };
};
services.gnome.gnome-keyring.enable = true;
security.pam.services.login.enableGnomeKeyring = true;
#______________________________________________________________________________________ 



    programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  hardware.graphics.enable = true;
  hardware.nvidia.open = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  

security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };


   users.users.soka = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; 
     packages = with pkgs; [
      tree
     ];
   };

environment.variables = { XCURSOR_THEME = "Bibata-Modern-Ice"; XCURSOR_SIZE = "24"; };

   environment.systemPackages = with pkgs; [
     vim 
     wget
     foot
     waybar 
     yazi
     waypaper
     swww
     bibata-cursors
     rofi
     github-desktop
     chromium
     polkit_gnome
     gnome-keyring
     libsecret
     stow
     yazi
     git
     neovim
     hyprpanel
     pavucontrol
     nordic
     nwg-look
     nitch
     waypaper
     swww
     nemo
   ];

 

fonts.packages = with pkgs; [
  # ... other fonts
  nerd-fonts.jetbrains-mono
  nerd-fonts.hack
  hackgen-nf-font
  font-awesome
];

 system.stateVersion = "25.11"; 

}

