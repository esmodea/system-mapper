
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  # Dependencies that Flutter needs to run
  buildInputs = with pkgs; [
    # Core development tools
    git
    which
    xz
    zip
    unzip
    curl
    xdg-user-dirs
    xdg-utils
    
    # Build essentials
    pkg-config
    clang
    clang-tools
    cmake
    ninja
    zlib
    
    # Libraries required by Flutter
    fontconfig
    gtk3
    glib
    pcre
    util-linux
    libselinux
    libsepol
    libthai
    libdatrie
    libXdmcp
    libXtst
    libxkbcommon
    dbus
    at-spi2-core
    
    # Graphics libraries
    mesa
    libglvnd
    
    # Additional libraries for Linux desktop development
    libepoxy
    
    # Android development (optional, uncomment if needed)
    jdk21_headless
    android-tools
  ];

  # Environment setup
  shellHook = ''
    # Add custom Flutter installation to PATH
    export PATH="$HOME/flutter/bin:$PATH"

    # Add java home to env
    export JAVA_HOME="/nix/store/mxf12821brqjb2kv1p3v8b9n6d5741y0-openjdk-21.0.12+8" # CHANGE THIS TO YOUR REAL JDK PATH WITH COMMAND: nix-store -q --references $(which javac) 2>/dev/null
    
    # XDG base directories - required by path_provider on Linux
    export XDG_CONFIG_HOME=''${XDG_CONFIG_HOME:-$HOME/.config}
    export XDG_DATA_HOME=''${XDG_DATA_HOME:-$HOME/.local/share}
    export XDG_CACHE_HOME=''${XDG_CACHE_HOME:-$HOME/.cache}
    
    # Explicitly set compilers so CMake can find them
    export CC="${pkgs.clang}/bin/clang"
    export CXX="${pkgs.clang}/bin/clang++"
    export LD="${pkgs.clang}/bin/ld"
    export AR="${pkgs.clang}/bin/llvm-ar"

    # Force CMake to use nix-shell's ninja, not /usr/bin/ninja
    export CMAKE_MAKE_PROGRAM="${pkgs.ninja}/bin/ninja"

    # Create a shim dir with symlinks to nix tools, placed before /usr/bin
    # so subprocesses (like Flutter's CMake invocation) find them first
    export NIX_SHIM_DIR="$(mktemp -d)"
    ln -sf "${pkgs.ninja}/bin/ninja"   "$NIX_SHIM_DIR/ninja"
    ln -sf "${pkgs.cmake}/bin/cmake"   "$NIX_SHIM_DIR/cmake"
    ln -sf "${pkgs.clang}/bin/clang"   "$NIX_SHIM_DIR/clang"
    ln -sf "${pkgs.clang}/bin/clang++" "$NIX_SHIM_DIR/clang++"
    export PATH="$NIX_SHIM_DIR:$PATH"

    # Set up Flutter environment variables
    export CHROME_EXECUTABLE="${pkgs.chromium}/bin/chromium"
    
    # Ensure Flutter can find libraries
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [
      pkgs.gtk3
      pkgs.glib
      pkgs.libepoxy
      pkgs.mesa
      pkgs.libglvnd
      pkgs.zlib
      pkgs.fontconfig
    ]}:$LD_LIBRARY_PATH"
    
    # Verify Flutter is available
    if command -v flutter &> /dev/null; then
      echo "Flutter found at: $(which flutter)"
      echo "Flutter version: $(flutter --version | head -n 1)"
    else
      echo "WARNING: Flutter not found at ~/flutter/bin/"
      echo "Please ensure Flutter is installed at ~/flutter/"
    fi
  '';
}
