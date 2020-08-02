let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
  #rustNightlyChannel = (nixpkgs.rustChannelOf { date = "2019-01-26"; channel = "nightly"; }).rust;
  rustStableChannel = nixpkgs.latest.rustChannels.stable.rust.override {
    extensions = [
      "rust-src"
      "rls-preview"
      "clippy-preview"
      "rustfmt-preview"
    ];
  };
in
with import <nixpkgs> {};
  stdenv.mkDerivation {
    name = "rust-env";
    nativeBuildInputs = [
      # rustc cargo

      # Build-time Additional Dependencies
      pkgconfig
      python3
    ];
    buildInputs = [
      # Run-time Additional Dependencies
      rustStableChannel
      
      freetype
      expat
      xorg.libxcb
      fontconfig
      libudev
      alsaLib
    ];

    # LD_LIBRARY_PATH = ''
    #   ${xorg.libXcursor}/lib:${xorg.libX11}/lib
    # '';
    LD_LIBRARY_PATH = stdenv.lib.makeLibraryPath [
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
      libglvnd


    ];

    # Set Environment Variables
    RUST_BACKTRACE = 1;
  }
