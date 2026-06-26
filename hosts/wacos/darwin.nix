{ pkgs, ... }:

{
  nix.enable = false;  # let Determinate Nix handle Nix configuration

  # Required to know which user to act on behalf of since activation now runs as root
  system.primaryUser = "alejandro";

  # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.stateVersion
  system.stateVersion = 5;

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  users.users.alejandro = {
    name = "alejandro";
    home = "/Users/alejandro";
  };

  programs.zsh.enable = true; # required for home-manager shell init

  # Apple system domain
  system.defaults = {
    dock.autohide = true;
    dock.autohide-delay = 0.0;     # default: 0.5
    dock.show-recents = false;
    dock.mru-spaces = false;       # dont reorder spaces by most-recent-used; default: true
    dock.expose-group-apps = true; # group windows by application in Mission Control; default: false
    dock.tilesize = 64;            # default: 64

    spaces.spans-displays = true; # separate spaces for each display; default: null

    finder.AppleShowAllExtensions = true;
    finder.AppleShowAllFiles = true;
    finder.ShowPathbar = true;
    #finder.ShowStatusBar = true;
    finder._FXSortFoldersFirst = true;
    finder.FXEnableExtensionChangeWarning = false;
    finder.FXDefaultSearchScope = "SCsp"; # use previous seach scope; default: "SCev" (This Mac)
    finder.FXPreferredViewStyle = "Nlsv"; # list view; default: "icnv" (icon view)

    NSGlobalDomain.KeyRepeat = 2;                    # default: 6
    NSGlobalDomain.InitialKeyRepeat = 15;            # default: 25
    NSGlobalDomain.ApplePressAndHoldEnabled = false; # default: true (accent menu displayed)
    NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
    NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
    NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
    #NSGlobalDomain."com.apple.swipescrolldirection" = false;
    NSGlobalDomain.AppleICUForce24HourTime = true;

    trackpad.TrackpadThreeFingerDrag = true;
    #trackpad.Clicking = true;
    trackpad.TrackpadRightClick = true;

    loginwindow.GuestEnabled = false;
  };

  # The following are not yet covered by nix-darwin mantainers
  system.defaults.CustomUserPreferences = {
    "com.apple.desktopservices" = {
      # Dont creates .DS_Store everywhere
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
  };

  # services.karabiner-elements.enable = true;
  services.aerospace = {
    enable = true;
  };

  homebrew = {
    enable = true;
    brews = [
      "container"
      "mole"
    ];
    casks = [
      "adguard"
      "karabiner-elements"
      "mac-mouse-fix@2"
    ];
    onActivation = {
      autoUpdate = true;  # self-update
      cleanup    = "zap"; # config is source of truth; removes anything not listed
    };
  };
}
