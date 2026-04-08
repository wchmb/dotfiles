{ config, ... }:

{
  programs.claude-code.enable = true;

  home.sessionVariables = {
    CLAUDE_CONFIG_DIR = "${config.xdg.configHome}/claude";
  };

  xdg.configFile."claude/settings.json".text = builtins.toJSON {
   env = {
      DISABLE_TELEMETRY                        = "1";
      DISABLE_ERROR_REPORTING                  = "1";
      CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1";
      CLAUDE_CODE_DISABLE_AUTO_MEMORY          = "1";
      CLAUDE_CODE_SUBPROCESS_ENV_SCRUB         = "1";
    };

    cleanupPeriodDays = 7;

    permissions = {
      deny = [
        "Read(./.env)"
        "Read(./.env.*)"
        "Read(./secrets/**)"
        "Read(~/.ssh/**)"
        "Read(~/.aws/**)"
        "Write(./.env)"
        "Write(./.env.*)"
        "Write(./secrets/**)"
        "Write(~/.ssh/**)"
        "Write(~/.aws/**)"
        "Bash(git push *)"
      ];
    };

    sandbox.enabled     = true;
    attribution.disable = true;
  };
}
