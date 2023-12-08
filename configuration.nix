# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; #set mount point
    };
    grub = {
      efiSupport = true;
      devices = "nodev";
    }
  networking.hostName = "karuto"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  #Setting up wifi
  networking.wireless.networks = {
    SON = {
      psk = "20222021";
    };
  }
  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };
  #config ibus
  i18n.inputMethod={
    enabled = "ibus";
    ibus.engines = with pkgs; [
      bamboo
      mozc
    ]; 
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the hyprland Desktop Environment.
  wayland.windowManager.hyprland = {
      enable = true;
      xwayland = true;
    };
  
  xdg.portal.wlr.enable = true #enable wlr-root
  # Configure keymap in X11
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.lightdm.enable = true;
    windowManager.awesome.enable = true;
  };

  # Enable CUPS and hp printer to print documents.
  services.printing = {
    enable = true;
    drivers = [
      pkgs.hplip
    ];
    logLevel = "debug";
  };
  users.users.Karuto.extraGroups = [ ... "lp" ... ];
    # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  #font install
  fonts.packages = with pkgs; [
    #all language font pkg
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    #coding pkg
    (nerdfonts.override{ fonts = [ "Hack" "JetBrainMono" ]; })
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.karuto = {
    isNormalUser = true;
    description = "Karuto";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
     #app and tools
      firefox
      kate
      waybar
      wofi
      rofi
      vscode
      nwg-look
      nwg-bar
      ranger
      cinnamon.nemo-with-extensions
      dunst
      zathura
      waypaper
      discord
      vencord
      cava
      wlsunset
      grimblast
      spotify
      betterdiscordctl
      gh
      libreoffice
      google-chrome
    #font and emoji
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      jetbrains-mono
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    wget
    curl
    wl-clipboard
    grimblast
    git
    man #read manual
    # system monitors
    zenith
    htop
    # hardware inform
    neofetch
    #term
    alacritty
    kitty
  ];
  #set default editor
  environment.variables = {
    EDITOR = "neovim";
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
