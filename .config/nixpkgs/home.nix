{ config, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
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
    # transmission
    transmission-gtk
    fd
    tree
    bat

    calibre
    syncplay
    # stlink

    krita
    gimp

    # dev
    # ghc
    cabal2nix
    nix-prefetch-git
    cabal-install
  ];

  programs.zsh = {
    enable = true;
    autocd = false;
    history = {
      extended = true;
      size = 100000;
    };
    initExtra = "eval \"$(direnv hook zsh)\"";
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
