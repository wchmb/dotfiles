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

  users.users.alejandro = {
    name = "alejandro";
    home = "/Users/alejandro";
  };

  programs.zsh.enable = true; # required for home-manager shell init

  # Apple system domain
  system.defaults = {
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    screencapture.location = "~/Desktop";
  };
}
