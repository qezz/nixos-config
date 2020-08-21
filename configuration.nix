{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;

    # network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # fixes ntp synchronization hang
    timeServers = [ "0.pool.ntp.org" ];

    # fixes weird dns resolv hang issue
    nameservers = [ "1.1.1.1" "9.9.9.9" ];
  };

  # internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # time zone.
  time.timeZone = "Europe/Moscow";

  # Allows to use several apps like Discord and Spotify
  nixpkgs.config.allowUnfree = true;

  # To search:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vim
    firefox
    # firefox-bin-unwrapped
    emacs
    pcmanfm
    
    tdesktop
    git
    discord
    spotify
    shutter
    alacritty

    rustup
    clang
    # pkg-config
    rustc
    cargo
    binutils
    gcc
    gnumake
    openssl
    pkgconfig
    postgresql

    wine
    winetricks
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.windowManager.i3.package = pkgs.i3-gaps;

  environment.pathsToLink = [ "/libexec" "/share/zsh" ];

  fonts.fonts = with pkgs; [
    # noto-fonts
    # noto-fonts-cjk
    # noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    # mplus-outline-fonts
    # dina-font
    # proggyfonts
    font-awesome_4
    terminus_font
    terminus_font_ttf
    ubuntu_font_family
    open-sans
  ];

  fonts.fontconfig.defaultFonts = {
    serif = [ "Ubuntu" ];
    sansSerif = [ "Ubuntu" ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  services = {
    postgresql = {
      enable = true;
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all ::1/128 trust
      '';
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE sergey WITH LOGIN PASSWORD 'password' CREATEDB;
        CREATE DATABASE db;
        GRANT ALL PRIVILEGES ON DATABASE db TO sergey;
      '';
    };

    openssh.enable = true;


    # Enable CUPS to print documents.
    printing.enable = true;

    xserver = {
      enable = true;
      layout = "us,ru";
      exportConfiguration = true;
      xkbOptions = "grp:win_space_toggle";
      
      libinput = {
        enable = true;
      };

      config = ''
        Section "InputClass"
          Identifier "mouse accel"
            Driver "libinput"
            MatchIsPointer "on"
            Option "AccelProfile" "flat"
            Option "AccelSpeed" "0"
        EndSection
      '';

      videoDriver = "amdgpu";


      # services.xserver.displayManager.sddm.enable = true;
      # services.xserver.desktopManager.plasma5.enable = true;


      desktopManager = {
        xterm.enable = false;
      };
      
      displayManager = {
        defaultSession = "none+i3";
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          dmenu #application launcher most people use
          i3status # gives you the default i3 status bar
          i3lock #default i3 screen locker
          i3blocks #if you are planning on using i3blocks over i3status
          i3status-rust
        ];
      };
    };
  };
  
  # Required to use zsh as default shell
  programs.zsh.enable = true;

  users.users.sergey = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "audio" "video" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

