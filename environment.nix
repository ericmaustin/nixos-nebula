{ config, pkgs, ... }:
let
  unstablePkgs = with pkgs.unstable; [
    awscli2
    blueman
    cargo
    chromium
    docker
    faba-icon-theme
    faba-mono-icons
    firefox
    genymotion
    gimp
    go
    google-cloud-sdk
    gparted
    inkscape
    kotlin
    kubectl
    kubernetes
    kubernetes-helm
    libsForQt5.kdeconnect-kde
    lispPackages.quicklisp
    neovim
    nodejs
    openjdk
    plasma5Packages.plasma-thunderbolt
    rust-analyzer
    rustc
    rustcat
    rustfmt
    rustup
    spotify
    steam
    steam
    stumpwm
    syncthing
    terraform
    watchman
    wirelesstools
  ];
in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.ca
    aspellDicts.en
    aspellDicts.es
    autoconf
    curl
    curl.dev
    dbus
    direnv
    ethtool
    eza
    fetchutils
    gcc
    ghostscript
    git
    gnumake
    gnupg
    imagemagick
    jq
    killall
    libgcc
    libsForQt5.kgpg # manage gnupg keys
    lm_sensors
    mu
    nixpkgs-fmt
    offlineimap
    openssl
    openssl.dev
    pass
    pciutils
    perl
    pkg-config
    python311Packages.pip
    qtox
    ruby
    sbt
    tmux
    tree
    uget
    unzip
    usbutils
    vlc
    wget
    wget
    xclip
    youtube-dl
  ] ++ unstablePkgs;

  environment.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    GOROOT = "${pkgs.go.out}/share/go";
  };

  # fonts
  fonts.packages = with pkgs; [
    inter
    roboto
    roboto-serif
    ubuntu_font_family
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    libre-baskerville
    jetbrains-mono
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Roboto Serif" ];
      sansSerif = [ "Inter" ];
      monospace = [ "JetBrainsMono" ];
    };
  };
}
