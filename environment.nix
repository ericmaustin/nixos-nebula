{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    dbus
    libgcc
    perl
    openssl
    openssl.dev
    pkg-config
    autoconf
    lm_sensors
    ethtool
    fetchutils
    usbutils
    pciutils
    wget
    eza
    gcc
    unstable.terraform
    python311Packages.pip
    unstable.kubernetes
    unstable.kubernetes-helm
    unstable.kubectl
    direnv
    jq
    killall
    tree
    wget
    git
    gnupg
    curl
    curl.dev
    unstable.chromium
    tmux
    gnumake
    unzip
    aspell
    aspellDicts.en
    aspellDicts.es
    aspellDicts.ca
    imagemagick
    offlineimap
    mu
    youtube-dl
    vlc
    xclip
    uget
    qtox
    ghostscript
    pass
    unstable.faba-icon-theme
    unstable.faba-mono-icons
    ruby
    sbt
    nixpkgs-fmt
    unstable.go
    unstable.openjdk
    unstable.nodejs
    unstable.watchman
    unstable.stumpwm
    unstable.lispPackages.quicklisp
    unstable.kubectl
    unstable.google-cloud-sdk
    unstable.awscli2
    unstable.neovim
    unstable.gparted
    unstable.gimp
    unstable.inkscape
    unstable.syncthing
    unstable.genymotion
    unstable.firefox
    unstable.wirelesstools
    unstable.steam
    unstable.spotify
    unstable.rustc
    unstable.cargo
    unstable.rustup
    unstable.rustfmt
    unstable.rustcat
    unstable.docker
    unstable.blueman
    unstable.kotlin
    unstable.rust-analyzer
    # use FHS chroot for vscode so we can use user sync
    unstable.libsForQt5.kdeconnect-kde
    unstable.plasma5Packages.plasma-thunderbolt
  ];

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
