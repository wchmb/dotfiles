{ ... }:

{
  # Required default settings
  # https://nikitabobko.github.io/AeroSpace/guide.html#a-note-on-displays-have-separate-spaces
  # https://nikitabobko.github.io/AeroSpace/guide.html#a-note-on-mission-control
  targets.darwin.defaults = {
    "com.apple.spaces" = {
      "spans-displays" = true;    # One space spans all displays
    };
    "com.apple.dock" = {
      "expose-group-apps" = true; # Group windows by app in Mission Control
    };
  };

  programs.aerospace = {
    enable = true;

    launchd = {
      enable    = true;
      keepAlive = true;  # default, can omit
    };

    settings = {
      accordion-padding = 30;

      automatically-unhide-macos-hidden-apps = false;

      default-root-container-layout      = "tiles"; # tiles | accordion
      default-root-container-orientation = "auto";

      enable-normalization-flatten-containers                         = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      # Mouse follow focus
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

      key-mapping.preset = "qwerty";

      gaps = {
        inner = {
          horizontal = [ { monitor.built-in = 3; } 4 ];
          vertical   = [ { monitor.built-in = 3; } 4 ];
        };
        outer = {
          left   = [ { monitor.built-in = 0; } 0 ];
          right  = [ { monitor.built-in = 0; } 0 ];
          top    = [ { monitor.built-in = 0; } 0 ];
          bottom = [ { monitor.built-in = 0; } 0 ];
        };
      };

      workspace-to-monitor-force-assignment = {
        "O-Code"   = [ "main" "built-in" ];
        "1-Init"   = [ "built-in" "secondary" ];
        "2-Comms"  = [ "built-in" "secondary" ];
        "3-System" = [ "built-in" "secondary" ];
        "4"        = [ "built-in" "secondary" ];
        "5"        = [ "built-in" "secondary" ];
        "6"        = [ "built-in" "secondary" ];
        "7"        = [ "main" "built-in" ];
        "8"        = [ "main" "built-in" ];
        "9-Browse" = [ "main" "built-in" ];
      };

      mode = {
        main.binding = {
          # Workspace focus
          alt-1 = "workspace 1-Init";
          alt-2 = "workspace 2-Comms";
          alt-3 = "workspace 3-System";
          alt-4 = "workspace 4";
          alt-5 = "workspace 5";
          alt-6 = "workspace 6";
          alt-7 = "workspace 7";
          alt-8 = "workspace 8";
          alt-9 = "workspace 9-Browse";
          alt-0 = "workspace O-Code";
          # alt-q = 'workspace ●○○○'
          # alt-w = 'workspace ○●○○'
          # alt-e = 'workspace ○○●○'
          # alt-r = 'workspace ○○○●'
          alt-leftSquareBracket  = "workspace --wrap-around prev";
          alt-rightSquareBracket = "workspace --wrap-around next";
          alt-tab = "workspace-back-and-forth";

          # Windows focus
          alt-h = "focus --ignore-floating --boundaries-action wrap-around-the-workspace left";
          alt-j = "focus --ignore-floating --boundaries-action wrap-around-the-workspace down";
          alt-k = "focus --ignore-floating --boundaries-action wrap-around-the-workspace up";
          alt-l = "focus --ignore-floating --boundaries-action wrap-around-the-workspace right";

          # Windows movements
          alt-ctrl-h = "move left";
          alt-ctrl-j = "move down";
          alt-ctrl-k = "move up";
          alt-ctrl-l = "move right";
          # To workspace
          alt-ctrl-1 = "move-node-to-workspace 1-Init";
          alt-ctrl-2 = "move-node-to-workspace 2-Comms";
          alt-ctrl-3 = "move-node-to-workspace 3-System";
          alt-ctrl-4 = "move-node-to-workspace 4";
          alt-ctrl-5 = "move-node-to-workspace 5";
          alt-ctrl-6 = "move-node-to-workspace 6";
          alt-ctrl-7 = "move-node-to-workspace 7";
          alt-ctrl-8 = "move-node-to-workspace 8";
          alt-ctrl-9 = "move-node-to-workspace 9-Browse";
          alt-ctrl-0 = "move-node-to-workspace O-Code";
          # To monitor
          # Note: move-workspace-to-monitor has no effect if workspace-to-monitor-force-assignment
          alt-ctrl-left  = "move-node-to-monitor --focus-follows-window prev";
          alt-ctrl-right = "move-node-to-monitor --focus-follows-window next";
          alt-ctrl-tab   = "move-workspace-to-monitor --wrap-around next";

          # Windows joins
          alt-shift-h = "join-with left";
          alt-shift-j = "join-with down";
          alt-shift-k = "join-with up";
          alt-shift-l = "join-with right";

          # Windows layouts
          alt-enter  = "layout floating tiling"; # toggles floating/tiling
          alt-slash  = "layout tiles horizontal vertical";
          alt-comma  = "layout accordion horizontal vertical";
          alt-f      = "fullscreen --no-outer-gaps";

          # Launch terminal
          alt-t = "exec-and-forget osascript -e 'tell application \"Terminal\" to do script' -e 'tell application \"Terminal\" to activate'";

          # Mode switches
          alt-r               = "mode resize";
          alt-shift-semicolon = "mode service";
        };

        resize.binding = {
          h     = "resize smart -50";
          j     = "resize smart-opposite -50";
          k     = "resize smart-opposite +50";
          l     = "resize smart +50";
          minus = "resize smart -50";
          equal = "resize smart +50";
          q     = "mode main";
        };

        service.binding = {
          r         = [ "flatten-workspace-tree" "mode main" ]; # Reset layout
          f         = [ "layout floating tiling" "mode main" ]; # Toggle floating <-> tiling
          backspace = [ "close-all-windows-but-current" "mode main" ];
          esc       = [ "reload-config" "mode main" ];
          q         = "mode main";
        };
      };

      # Get app-id with: aerospace list-apps
      on-window-detected = [
        #{ "if".app-id = "com.apple.Music";             run = "move-node-to-workspace 1-Init"; }
        { "if".app-name-regex-substring = "YT Music";  run = "move-node-to-workspace 1-Init"; }
        { "if".app-id = "com.apple.mail";              run = "move-node-to-workspace 2-Comms"; }
        { "if".app-name-regex-substring = "Messages";  run = "move-node-to-workspace 2-Comms"; }
        { "if".app-id = "net.whatsapp.WhatsApp";       run = "move-node-to-workspace 2-Comms"; }
        { "if".app-name-regex-substring = "Chat";      run = "move-node-to-workspace 2-Comms"; }
        { "if".app-id = "com.apple.Safari";            run = "move-node-to-workspace 9-Browse"; }
        { "if".app-id = "org.gnu.Emacs";               run = "move-node-to-workspace O-Code"; }
        { "if".app-id = "com.apple.Terminal";          run = "move-node-to-workspace O-Code"; }
        { "if".app-name-regex-substring = "AI Studio"; run = "move-node-to-workspace O-Code"; }
        { "if".app-name-regex-substring = "Perplexit"; run = "move-node-to-workspace O-Code"; }

        # Everythig else floating
        { run = "layout floating"; }  # catch-all
      ];
    };
  };
}
