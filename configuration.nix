# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./environment.nix
      ./users.nix
    ];
  
   nix = {
     package = pkgs.nixFlakes;
     extraOptions = ''
       experimental-features = nix-command flakes
     '';
  };

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot = {
    consoleLogLevel = 2;
    supportedFilesystems = [ "ntfs" "zfs" ];
    zfs.forceImportRoot = false;
    kernelParams = [ 
      "nosgx" 
      "quiet"
      "splash"
      "boot.shell_on_fail"
    ];
    hardwareScan = true;
    # modules to load early in the boot process, for nicer boot splash at correct rez
    initrd = {
      verbose = false;
      kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    };
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 30;
      grub = {
        devices = [ "nodev" ];
        enable = true;
        useOSProber = true;
        efiSupport = true;
        #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
        device = "nodev";
        theme = pkgs.fetchFromGitHub {
          owner = "shvchk";
          repo = "fallout-grub-theme";
          rev = "e8433860b11abb08720d7c32f5b9a2a534011bca";
          sha256 = "sha256-mvb44mFVToZ11V09fTeEQRplabswQhqnkYHH/057wLE=";
        };
      };
    };
  };

  # networking
  networking = {
    hostName = "nixnebula1";
    # generated with: head -c4 /dev/urandom | od -A none -t x4
    hostId = "e01f0eed";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        # spotify
        57621
        5353
	# printing / cups
	631
      ];
      allowedUDPPorts = [
        # spotify
        5353
	# printing / cups
	631
      ];
    };
  };

  time = {
    timeZone = "America/Chicago";
    # fix dual boot windows time issue    
    hardwareClockInLocalTime = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    layout = "us";
    xkbVariant = "";
    # Enable touchpad support
    libinput.enable = true;
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "eric";
    #displayManager.defaultSession = "plasmawayland";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # enable opengl
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # nvidia settings
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  #Enable the OpenSSH daemon.
  services.openssh.enable = true;

  #enable thunderbolt
  services.hardware.bolt.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    allowFrom = [ "all" ];
    browsing = true;
    #stateless = true;
    drivers = [ pkgs.epson-escpr2 pkgs.canon-cups-ufr2 ];
  };

  #enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
    publish.enable = true;
    publish.workstation = true;
    publish.addresses = true;
  };

  #docker
  virtualisation.docker.enable = true;

  # sleep config
  systemd = {
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = true;
      hybrid-sleep.enable = false;
    };
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; 
}
