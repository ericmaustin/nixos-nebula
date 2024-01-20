{ config, pkgs, ... }:
let
  unstablePkgs = with pkgs.unstable; [
    android-studio
    conky
    deluged
    discord
    drawio
    granted # cloud cli tool
    libreoffice-qt
    obsidian
    pandoc
    rclone
    rclone-browser
    slack
    vscode.fhs
    zoom-us
  ];

  jetbrainsPkgs = with pkgs.unstable.jetbrains; [
    # jetbrains stuff with copilot plugins enabled by default via nix as 
    # copilot won't work on nixos if installed via IDE
    (plugins.addPlugins goland [
      "github-copilot"
      "nixidea"
      "ideavim"
      "csv-editor"
    ])
    (plugins.addPlugins clion [
      "github-copilot"
      "nixidea"
      "ideavim"
      "rust"
      "csv-editor"
    ])
    (plugins.addPlugins rust-rover [
      "github-copilot"
      "nixidea"
      "ideavim"
      "csv-editor"
    ])
    (plugins.addPlugins pycharm-professional [
      "github-copilot"
      "nixidea"
      "ideavim"
      "csv-editor"
    ])
    (plugins.addPlugins idea-ultimate [
      "github-copilot"
      "nixidea"
      "csv-editor"
      "ideavim"
      "rust"
    ])
  ];
in
{
  home.username = "eric";
  home.homeDirectory = "/home/eric";

  home.packages = with pkgs; [
    openssl
    openssl.dev
    perl
  ] ++ unstablePkgs ++ jetbrainsPkgs;

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = with pkgs.unstable; {
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
      nixos-rebuild-nebula = "nixos-rebuild --flake .#nixnebula switch";
      # open vscode as root
      rootcode = "sudo code . --no-sandbox --user-data-dir /root/.vscode";
      assume = "source ${granted}/bin/.assume-wrapped";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "docker"
        "git"
        "golang"
        "kubectl"
        "node"
        "pyenv"
        "python"
        "rust"
        "rust"
        "sudo"
      ];
      theme = "refined";
    };
    initExtra = ''
      # set PATH so it includes user's private npm bin if it exists
      export PATH="$PATH:$HOME/.npm-global/bin"
      # set PATH so it includes user's private cargo bin if it exists
      export PATH="$PATH:$HOME/.cargo/bin"
      # set PATH so it includes user's private go bin if it exists
      export PATH="$PATH:$HOME/go/bin"
      # enable direnv
      eval "$(direnv hook zsh)"
      # enable aws cli completion
      complete -C $(which aws_completer) aws
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    GOROOT = "${pkgs.go.out}/share/go";
  };

  programs.git = {
    enable = true;
    userName = "Eric Austin";
    userEmail = "eric.m.austin@gmail.com";
    extraConfig = {
      pull.ff = "only";
      core = {
        autocrlf = "input";
        whitespace = "fix,-indent-with-non-tab";
        commentChar = "auto";
      };
      rebase = {
        autosquash = true;
        autostash = true;
        updateRefs = true;
      };
      push = {
        autoSetUpRemote = true;
      };
      init = {
        defaultBranch = "main";
      };
    };
    aliases = {
      ci = "commit";
      ca = "commit --amend";
      can = "commit --amend --no-edit";
      dc = "diff --cached";
      di = "diff";
      fp = "push --force-with-lease";
      co = "checkout";
      s = "status";
      fpstack = "\!git log --decorate=short --pretty='format:%D' origin/main.. | sed 's/, /\\n/g; s/HEAD -> //'  | grep -Ev '/|^$' | xargs git push --force-with-lease origin";
      l = "log --oneline";
      pullrb = "pull --rebase";
      pullrbi = "pull --rebase --interactive";
      rc = "rebase --continue";
      st = "status --short";
      sw = "switch";
      graph = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset); - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
    };
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
          blue = "0x61afef";
          magenta = "0xc678dd";
          cyan = "0x56b6c2";
          white = "0xffffff";
        };
      };
    };
  };
}
