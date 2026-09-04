{ config, lib, pkgs, go2one, system, ... }:

{
  imports = [
    ./modules/wezterm.nix
    ./modules/fzf.nix
    ./modules/ssh.nix
    ./modules/git.nix
    ./modules/zsh.nix
    ./modules/starship.nix
    ./modules/claude-code.nix
  ];

  home.username = "leoluz";
  home.homeDirectory = "/Users/leoluz";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  # ~/.config/nvim as a home-manager-managed symlink into the go2one flake
  # input, so nvim's standard config resolution finds it directly.
  xdg.configFile."nvim".source = "${go2one}/nvim";

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
    go2one.packages.${system}.default # neovim, preconfigured via github:leoluz/go2one
    kubectl
    fzf

    # utils
    ripgrep # Recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fastfetch
    rectangle # MacOS window manager
    raycast # App launcher that works with Nix symlinks
    fd # A simple, fast and user-friendly alternative to 'find'
    gnupg # gpg
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
