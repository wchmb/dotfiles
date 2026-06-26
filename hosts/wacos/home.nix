{ ... }:

{
  imports = [
    ../../home.nix
    ../../home/macos.nix
    ../../home/aerospace.nix
    ../../home/karabiner.nix
  ];

  home.homeDirectory = "/Users/alejandro";
}
