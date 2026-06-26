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

  # services.karabiner-elements.enable = true;
  services.aerospace = {
    enable = true;
  };

  users.users.alejandro = {
    name = "alejandro";
    home = "/Users/alejandro";
  };

  programs.zsh.enable = true; # required for home-manager shell init

  # Apple system domain
  system.defaults = {
    dock.autohide = true;          # default: false
    dock.autohide-delay = 0.0;     # default: 0.5
    dock.show-recents = false;     # default: true
    dock.mru-spaces = false;       # dont reorder spaces by most-recent-used; default: true
    dock.expose-group-apps = true; # group windows by application in Mission Control; default: false
    dock.tilesize = 64;            # default: 64

    spaces.spans-displays = true; # separate spaces for each display; default: null

    finder.AppleShowAllExtensions = true;          # default: false
    finder.AppleShowAllFiles = true;               # default: false
    finder.ShowPathbar = true;                     # default: false
    #finder.ShowStatusBar = true;                  # default: false
    finder._FXSortFoldersFirst = true;             # default: false
    finder.FXEnableExtensionChangeWarning = false; # default: true
    finder.FXDefaultSearchScope = "SCsp";          # use previous seach scope; default: "SCev" (This Mac)
    finder.FXPreferredViewStyle = "Nlsv";          # list view; default: "icnv" (icon view)

    NSGlobalDomain.KeyRepeat = 2;                                # default: 6
    NSGlobalDomain.InitialKeyRepeat = 15;                        # default: 25
    NSGlobalDomain.ApplePressAndHoldEnabled = false;             # default: true (accent menu displayed)
    NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;     # default: true
    NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;   # default: true
    NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false; # default: true
    NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;  # default: true
    #NSGlobalDomain."com.apple.swipescrolldirection" = false;    # default: true
    NSGlobalDomain.AppleICUForce24HourTime = true;               # default: false

    trackpad.TrackpadThreeFingerDrag = true; # default: false
    #trackpad.Clicking = true;               # default: false
    trackpad.TrackpadRightClick = true;      # default: false

    loginwindow.GuestEnabled = false; # default: true
  };

  # The following are not yet covered by nix-darwin mantainers
  system.defaults.CustomUserPreferences = {
    "com.apple.desktopservices" = {
      # Dont creates .DS_Store everywhere
      DSDontWriteNetworkStores = true;
      DSDontWriteUSBStores = true;
    };
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
