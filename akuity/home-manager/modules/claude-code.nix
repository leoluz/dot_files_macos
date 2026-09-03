{ ... }:

{
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