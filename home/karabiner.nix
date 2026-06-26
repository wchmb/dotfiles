{ pkgs, ... }:

{
# Karabiner v15 broken: https://github.com/nix-darwin/nix-darwin/issues/1041
# TODO installed with brew. uncomment when fixed upstream
#  home.packages = [ pkgs.karabiner-elements ];
  xdg.configFile."karabiner/karabiner.json" = {
    source = ../dotfiles/karabiner.json;
    force  = true;
  };
  xdg.stateFile."karabiner/.keep".text = "";
}
