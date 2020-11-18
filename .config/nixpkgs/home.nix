{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  # allowUnfree = true;
  nixpkgs.config.allowUnfree = true;

  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

  xsession.pointerCursor = {
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
    size = 16;
  };

  home.packages = with pkgs; [
    htop
    konsole
    zsh
    nix-index
    direnv
    du-dust
    tokei
    file
    steam
    vlc
    mpv

    dunst

    # transmission
    transmission-gtk
    libreoffice

    testdisk-qt
    
    fd
    tree
    bat
    exa

    # python-language-server # nix-env -f https://github.com/NixOS/nixpkgs/archive/master.tar.gz -iA python-language-server
    python-language-server

    cron
    # redshift
    redshift-wlr
    hicolor-icon-theme
    # aws-sam-cli

    # calibre
    syncplay
    # stlink
    zoom-us
    # teams # install from master, it includes the fix for screen sharing

    krita
    gimp
    zathura
    flameshot

    kicad
    # yed # install from master
    # obsidian # install via: nix-env -f https://github.com/NixOS/nixpkgs/archive/master.tar.gz -iA obsidian

    mailspring #  nix-env -f https://github.com/NixOS/nixpkgs/archive/master.tar.gz -iA mailspring
    libsecret
    thunderbird

    # aws
    awscli

    unrar
    unzip

    # dev
    # ghc
    cabal2nix
    nix-prefetch-git
    cabal-install

    zola
  ];

  programs.zsh = {
    enable = true;
    autocd = false;
    history = {
      extended = true;
      size = 100000;
    };
    initExtra = "eval \"$(direnv hook zsh)\"; alias l='exa -la'";
    envExtra = "PATH=$PATH:$HOME/bin:$HOME/.cargo/bin
NIX_PAGER=";
    
    oh-my-zsh = {
      enable = true;
      custom = "\$HOME/.config/zsh_custom";
      theme = "gentoo-qezz"; # gentoo theme but RPROMPT is removed
      plugins = [ "git" "sudo" ];
    };
  };

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
    enableZshIntegration = true;
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Ubuntu Mono 11";
        markup = "full";
        format = "<b>%s</b>\n%b";
        sort = "yes";
        indicate_hidden = "yes";
        alignment = "left";
        bounce_freq = 0;
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        geometry = "300x5-40+30";
        shrink = "yes";
        transparency = 10;
        idle_threshold = 120;
        monitor = 0;
        follow = "mouse";
        sticky_history = "yes";
        history_length = 100;
        show_indicators = "yes";
        line_height = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        separator_color = "frame";
        frame_width = 1;
        # startup_notification = true;
        # dmenu = /usr/bin/dmenu -p dunst:;
        # browser = /usr/bin/firefox -new-tab;
        icon_position = "left";
        max_icon_size = 40;
      };
      shortcuts = {
        history = "ctrl+shift+minus";
      };

      urgency_low = {
        background = "#222222";
        foreground = "#888888";
        timeout = 10;
      };
      urgency_normal = {
        background = "#222222";
        foreground = "#888888";
        timeout = 10;
      };
      urgency_critical = {
        background = "#aa2222";
        foreground = "#000000";
        timeout = 10;
        frame_color = "#ff0000";
      };
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
