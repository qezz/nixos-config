{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  # allowUnfree = true;
  nixpkgs.config.allowUnfree = true;

  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

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
