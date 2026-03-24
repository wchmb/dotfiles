{ ... }:

{
  imports = [
    ../../home.nix
    # Linux-only modules here
  ];

  home.homeDirectory = "/home/alejandro";
}
