{ config, lib, pkgs, ... }:

{
  home.username = "leoluz";
  home.homeDirectory = "/Users/leoluz";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # fonts
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.symbols-only

    # development
    go
    nodejs
    gh
    nixd # Nix Language Server for LSP support
    tree-sitter
    neovim

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fastfetch
    rectangle # MacOS window manager
    raycast # App launcher that works with Nix symlinks
    fd
    gnupg #gpg
  ];

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  # Register apps directly in ~/Applications so spotlight can find them
  home.activation.aliasApplications =
    let
      appsToLink = with pkgs; [
        wezterm
        rectangle
        raycast
      ];
      appPaths = lib.concatMapStringsSep " " (pkg: "${pkg}/Applications/*.app") appsToLink;
    in
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      for src in ${appPaths}; do
        target="$HOME/Applications/$(basename "$src")"
        rm -f "$target"
        ln -sf "$src" "$target"
      done
    '';

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ssh = {
    enable = true;
    settings."*" = {
      identityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
    };
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "leoluz";
      email = "leonardo.almeida@akuity.io";
    };

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICEceksjHRzE8SOBtXWuUdB6XSsyDgjZ4EZO7qLG8su4";
      format = "ssh";
      signByDefault = true;
      signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting.enable = true;
    localVariables = {
      GOBIN = "$HOME/go/bin";
      PATH = "$GOBIN:$PATH";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "fzf" ];
      theme = "refined";
      # theme = "kolo";
    };

    shellAliases = {
      ll = "eza -l --icons=auto";
      l = "eza -la --icons=auto";
      update = "sudo nixos-rebuild switch --flake .";
    };
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };

  programs.zsh.shellAliases = {
    hms = "home-manager switch -b backup --flake ${config.home.homeDirectory}/git/dot_files_macos/akuity/home-manager#leoluz";
  };

  programs.claude-code = {
    enable = true;
  
    settings = {
      theme = "dark";
      permissions = { };
    };
  
    # Written to ~/.claude/CLAUDE.md — global context/instructions
    context = ''
      Prefer concise commit messages.
      Always run tests before considering a task done.
    '';
  
    # MCP servers, declaratively — merged into ~/.claude/settings.json / mcp config
    mcpServers = {
      github = {
        type = "stdio";
        command = "npx";
        args = [ "-y" "@modelcontextprotocol/server-github" ];
        env = { GITHUB_TOKEN = "$GITHUB_TOKEN"; };
      };
    };
  
    # Custom slash commands: ~/.claude/commands/<name>.md
    commands = {
      deploy = ''
        Run the deploy script and report the result.
      '';
    };
  
    # Custom subagents: ~/.claude/agents/<name>.md
    agents = { };
  };
}
