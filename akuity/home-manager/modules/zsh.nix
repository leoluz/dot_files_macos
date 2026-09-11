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
      # theme = "refined";
      # theme = "kolo";
    };

    shellAliases = {
      # oh-my-zsh's git plugin binds gm to "git merge"; override it so it
      # reaches our own `gm` git alias (see modules/git.nix) instead.
      gm = "git gm";
      ll = "eza -l --icons=auto";
      l = "eza -la --icons=auto";
      update = "sudo nixos-rebuild switch --flake .";
      hms = "home-manager switch -b backup --flake ${config.home.homeDirectory}/git/dot_files_macos/akuity/home-manager#leoluz";
      # Same as hms, but builds nvim from the local go2one checkout instead of
      # the pinned flake.lock commit, so local edits apply without commit/push.
      hms-dev = "home-manager switch -b backup --flake ${config.home.homeDirectory}/git/dot_files_macos/akuity/home-manager#leoluz --override-input go2one path:${config.home.homeDirectory}/git/go2one";
    };
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
}
