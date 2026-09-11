{ pkgs, ... }:

let
  # Backing script for the `gm` alias below, kept as a real file (rather than
  # an inline one-liner) so it's readable and shellcheck-checked at build time.
  git-gm = pkgs.writeShellApplication {
    name = "git-gm";
    runtimeInputs = [ pkgs.git pkgs.gawk pkgs.gnused ];
    text = ''
      # Prefer the "upstream" remote (fork workflow); fall back to "origin".
      remote=upstream
      git remote get-url upstream >/dev/null 2>&1 || remote=origin

      echo "Fetching $remote..."
      git fetch "$remote"

      # Ask the remote for its default branch directly, rather than relying on
      # a local refs/remotes/*/HEAD symref that may never have been set up.
      branch=$(git ls-remote --symref "$remote" HEAD | awk 'NR==1{print $2}' | sed 's#refs/heads/##')

      git checkout "$branch" 2>/dev/null || git checkout -b "$branch" "$remote/$branch"
      git rebase "$remote/$branch"
    '';
  };
in
{
  home.packages = [ git-gm ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "leoluz";
      email = "leoluz@users.noreply.github.com";
    };

    settings.alias = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --";
      branches = "for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'";
      gm = "!git-gm";
    };

    settings.rerere.enable = true;
    settings.difftool.prompt = false;

    settings.merge = {
      keepBackup = false;
      tool = "nvim";
    };

    settings.mergetool = {
      prompt = false;
      keepBackup = false;
      nvim.cmd = ''nvim -f -c "DiffviewOpen"'';
    };

    settings.core.editor = "nvim";
    settings.rebase.autosquash = true;
    settings.url."git@github.com:".insteadOf = "https://github.com/";
    settings.pull.ff = "only";
    settings.push.default = "current";

    includes = [
      {
        condition = "gitdir:~/git/akuity/";
        contents.user.name = "Leonardo Luz Almeida";
        contents.user.email = "leonardo.almeida@akuity.io";
      }
    ];

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICEceksjHRzE8SOBtXWuUdB6XSsyDgjZ4EZO7qLG8su4";
      format = "ssh";
      signByDefault = true;
      signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
  };
}