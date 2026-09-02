{ config, lib, pkgs, ... }:

{
  home.username = "leoluz";
  home.homeDirectory = "/Users/leoluz";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fd
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

  programs.git = {
    enable = true;
    userName = "leoluz";
    userEmail = "leonardo.almeida@akuity.io";
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
