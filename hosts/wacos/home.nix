{ ... }:

{
  imports = [
    ../../home.nix
    ../../modules/macos.nix
    ../../modules/aerospace.nix
    ../../modules/karabiner.nix
  ];

  home.homeDirectory = "/Users/alejandro";
}
