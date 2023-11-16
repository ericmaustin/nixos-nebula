{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    lm_sensors
    ethtool
    fetchutils
    usbutils
    pciutils
    wget
    eza
    docker
    gcc
    terraform
    python311Packages.pip
    kubernetes
    kubernetes-helm
    kubectl
    direnv
    jq
    neovim
    killall
    tree
    wget
    git
    gnupg
    curl
    chromium
    firefox
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
    gparted
    uget
    qtox
    gimp
    inkscape
    ghostscript
    blueman
    pass
    faba-icon-theme
    faba-mono-icons
    wirelesstools
    syncthing
    ruby
    sbt
    go
    openjdk
    nodejs
    watchman
    android-studio
    genymotion
    stumpwm
    lispPackages.quicklisp
    kubectl
    google-cloud-sdk
    awscli2
    steam
    spotify
    rustc
    cargo
    rustup
    rustfmt
    rustcat
    docker
    alacritty
    kotlin
    rust-analyzer
    # use FHS chroot for vscode so we can use user sync
    vscode.fhs
    jetbrains.rust-rover
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.goland
    jetbrains.datagrip
    jetbrains-toolbox
    jetbrains.webstorm
    libsForQt5.kdeconnect-kde
    plasma5Packages.plasma-thunderbolt
  ];

  environment.variables = { 
    GOROOT = [ "${pkgs.go.out}/share/go" ]; 
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
