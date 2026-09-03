{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/wezterm.nix
    ./modules/fzf.nix
    ./modules/ssh.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/claude-code.nix
  ];

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
}