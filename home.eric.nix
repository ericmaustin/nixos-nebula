{ config, pkgs, ... }:
{
  home.username = "eric";
  home.homeDirectory = "/home/eric";

  home.packages = with pkgs; [
    conky
    alacritty
    obsidian
    discord
    deluged
    zoom-us
    slack
    libreoffice-qt
  ];

  home.stateVersion = "23.05";
  
  programs.home-manager.enable = true;
  
  programs.zsh = {
    enable = true;
    enableCompletion = false; # enabled in oh-my-zsh
    shellAliases = {
        c = "clear";
        h = "history";
        wg = "wget -c";
        # nix stuff
        ne = "nix-env";
        ni = "nix-env -iA";
        no = "nixops";
        ns = "nix-shell --pure";
        # vim stuff
        vim = "nvim";
        vi = "nvim";
        v = "nvim";
        svi = "sudo nvim";
        sv = "sudo nvim";
        # replacements
        rm = "rm -I --preserve-root";
        ln = "ln -i";
        df = "df -h";
        du = "du -h";
        ls = "eza -a";
        ll = "eza -la";
        # open vscode as root
        rootcode = "sudo code . --no-sandbox --user-data-dir /root/.vscode";
    };
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "sudo" "docker" "kubectl" "rust" "golang" "python" "pyenv" "rust" "node"];
      theme = "refined";
    };
  };
  
  programs.git = {
    enable = true;
    userName = "Eric Austin";
    userEmail = "eric.m.austin@gmail.com";
  };

  services.gpg-agent = {                          
     enable = true;
     defaultCacheTtl = 1800;
     enableSshSupport = true;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        "TERM" = "xterm-256color";
      };
      window = {
        padding.x = 10;
        padding.y = 10;
      };
      font = {
        size = 12.0;
        normal.family = "JetBrainsMono Nerd Font";
        bold.family = "JetBrainsMono Nerd Font";
        italic.family = "JetBrainsMono Nerd Font";
      };
      shell.program = "${pkgs.zsh}/bin/zsh";
      colors = {
        primary = {
            background = "0x1e2127";
            foreground = "0xabb2bf";
            bright_foreground = "0xe6efff";
        };
        normal = {
            black = "0x1e2127";
            red = "0xe06c75";
            green = "0x98c379";
            yellow = "0xd19a66";
            blue = "0x61afef";
            magenta = "0xc678dd";
            cyan = "0x56b6c2";
            white = "0xabb2bf";
        };
        bright = {
            black = "0x5c6370";
            red = "0xe06c75";
            green = "0x98c379";
            yellow = "0xd19a66";
            blue =  "0x61afef";
            magenta = "0xc678dd";
            cyan = "0x56b6c2";
            white = "0xffffff";
        };
      };
    };
  };
}
