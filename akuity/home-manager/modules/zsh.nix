{ config, ... }:

{
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
      hms = "home-manager switch -b backup --flake ${config.home.homeDirectory}/git/dot_files_macos/akuity/home-manager#leoluz";
    };
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
}