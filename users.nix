{ config, pkgs, ... }:

{
  # enable zsh
  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eric = {
    isNormalUser = true;
    description = "Eric Austin";
    extraGroups = [ "networkmanager" "wheel" "shared" "media" "wireshark" "docker" ];
    packages = with pkgs; [
      firefox
    ];
    shell = "${pkgs.zsh}/bin/zsh";
  };

  # temp file systems
  fileSystems."/home/eric/downloads" = { device = "tmpfs"; fsType = "tmpfs"; options = [ "size=25%" ]; };
  fileSystems."/home/eric/sandbox" = { device = "tmpfs"; fsType = "tmpfs"; options = [ "size=25%" ]; };
}
