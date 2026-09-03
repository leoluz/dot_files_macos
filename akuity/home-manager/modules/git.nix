{ ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      name = "leoluz";
      email = "leoluz@users.noreply.github.com";
    };

    settings.alias = {
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --";
      branches = "for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'";
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