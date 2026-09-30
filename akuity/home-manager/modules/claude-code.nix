{ ... }:

{
  programs.claude-code = {
    enable = true;

    settings = {
      model = "claude-opus-5-5";
      theme = "dark";
      tui = "default";
      permissions = { };
      attribution.commit = "";
    };

    # Written to ~/.claude/CLAUDE.md — global context/instructions
    context = ''
      Prefer concise commit messages.
      Never add a `Co-Authored-By: Claude ...` trailer (or any other Claude attribution line) to commit messages.
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
