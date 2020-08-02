with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "rust-env";
  nativeBuildInputs = [
    rustc cargo

    # Build-time Additional Dependencies
    pkgconfig
    python3
  ];
  buildInputs = [
    # Run-time Additional Dependencies
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
