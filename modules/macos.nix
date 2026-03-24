{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    #container
    mos
    #subsurface
  ];

  home.sessionPath = [
    "/Library/Developer/CommandLineTools/usr/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
  ];

  home.sessionSearchVariables = {
    FPATH = [ "/opt/homebrew/share/zsh/site-functions" ];
  };

  # fix: M-x not working in Terminal.app: use Option as Meta
#  home.activation.terminalMetaKey = lib.hm.dag.entryAfter ["writeBoundary"] ''
#    PROFILE=$(defaults read com.apple.Terminal "Default Window Settings")
#    PLIST="$HOME/Library/Preferences/com.apple.Terminal.plist"
#    /usr/bin/plutil -replace "Window Settings.''${PROFILE}.useOptionAsMetaKey" -bool YES "''${PLIST}"
#  '';

  targets.darwin.defaults."com.caldis.Mos" = {
    smooth  = 1;
    reverse = false;
    toggle  = 56;

    speed    = 1;
    duration = 4.5;
    step     = 35;

    hideStatusItem = 1;
  };
}
