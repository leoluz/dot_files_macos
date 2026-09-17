{ config, ... }:

{
  # ~/.rd/bin holds Rancher Desktop's docker/helm/nerdctl/kubectl shims.
  # Rancher Desktop only adds it to PATH for interactive shells (it patches
  # ~/.zshrc/~/.bashrc directly), so any non-interactive process spawned
  # without sourcing those rc files - `make`/goreman child processes, IDE run
  # tasks, cron - can't find `docker` at all. home.sessionPath instead lands
  # in hm-session-vars.sh, which ~/.zshenv and ~/.zprofile source
  # unconditionally, so it covers every shell, not just interactive ones.
  #
  # ~/.local/bin is listed first so it's prepended ahead of ~/.rd/bin (see
  # home.file below for why).
  home.sessionPath = [ "$HOME/.local/bin" "$HOME/.rd/bin" ];

  # Rancher Desktop's containerd engine mode doesn't run a Docker-API-compatible
  # daemon, so the real `docker` CLI in ~/.rd/bin can't connect to anything.
  # Shadow it with nerdctl, which Rancher Desktop does keep working in that
  # mode and is close to drop-in compatible. This has to live ahead of
  # ~/.rd/bin in PATH (not just be a shell alias) so it's picked up by
  # subprocesses that exec "docker" directly, e.g. the argocd e2e suite.
  home.file.".local/bin/docker" = {
    text = ''
      #!/usr/bin/env bash
      exec nerdctl "$@"
    '';
    executable = true;
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
      plugins = [ "git" "fzf" "kubectl" "argocd"];
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
      # Bumps flake.lock to the latest commit of every input (nixpkgs,
      # home-manager, go2one, ...), then switches. Kept separate from hms so
      # a plain switch always rebuilds the exact pinned versions.
      hms-update = "nix flake update --flake ${config.home.homeDirectory}/git/dot_files_macos/akuity/home-manager && home-manager switch -b backup --flake ${config.home.homeDirectory}/git/dot_files_macos/akuity/home-manager#leoluz";
      # gh's macOS keyring access fails when invoked from Neovim's non-interactive
      # job/exec context (:!  or plugin jobstart), even though it works fine from
      # an interactive shell. Pull the token from Keychain here instead, where it's
      # known to work, and hand it only to this one nvim process's environment.
      nvim = "GH_TOKEN=$(gh auth token) nvim";
    };
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
}
