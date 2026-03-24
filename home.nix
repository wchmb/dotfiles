{ config, pkgs, ... }:

{
  imports = [
  ];

  home.username = "alejandro";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # cli tools
    less
    wget
    # TODO move to module/emacs.nix
    # email
    isync
    msmtp
    mu

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Environment variables
  home.sessionVariables = {
    # EDITOR = "emacs";
    HISTTIMEFORMAT = "%F %T ";
    HOMEBREW_NO_ENV_HINTS = "1";
    LESSHISTFILE = "${config.xdg.stateHome}/less/history";
    PYTHON_HISTORY = "${config.xdg.stateHome}/python/history";
    FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/nix#darwinConfigurations.${config.home.username}";
    SDKROOT = "\$(xcrun --sdk macosx --show-sdk-path)"; # Base SDK for building
    WGETRC = "${config.xdg.configHome}/wgetrc";
  };

  # Extra directories to prepend to PATH.
  home.sessionPath = [
    "${config.home.homeDirectory}/.emacs.d/bin"
    "${config.home.homeDirectory}/.docker/bin"
    "${config.home.homeDirectory}/.local/bin"
  ];

  # Extra directories to prepend to arbitrary PATH-like environment variables (e.g.: MANPATH)
  home.sessionSearchVariables = {
    MANPATH = [
      "${config.xdg.configHome}/.local/share/man"
    ];
    FPATH = [
      "${config.home.homeDirectory}/.docker/completions"
    ];
  };

  # Setup XDG
  xdg.enable = true;
  xdg.configFile = {
    "git/message.txt".source  = ./dotfiles/git-message.txt;
    "zsh/functions.sh".source = ./dotfiles/zsh-functions.sh;
    "isyncrc".source          = ./dotfiles/mbsyncrc;
    "msmtp/config".source     = ./dotfiles/msmtprc;
    "wgetrc".text = ''
      hsts-file = ${config.xdg.stateHome}/wget/history
    '';
  };
  xdg.stateFile = {
    # Create a .keep file, which forces the directory to be created
    "less/.keep".text   = "";
    "python/.keep".text = "";
    "wget/.keep".text   = "";
  };

  # Make programs use XDG directories whenever supported
  home.preferXdgDirectories = true;

  programs.git = {
    enable = true;

    settings = {
      user.name  = "Alejandro Blaco";
      user.email = "alebdm@icloud.com";

      core.editor     = "vim";
      pull.rebase     = true;
      commit.template = "${config.xdg.configHome}/git/message.txt";
    };
  };

  programs.zsh = {
    enable = true;

    dotDir = "${config.xdg.configHome}/zsh";

    autosuggestion.enable = true;

    history = {
      append     = true;
      extended   = true;
      ignoreDups = true;
      size       = 10000;
      save       = 10000;
    };

    setOptions = [
      # Dirstack
      "AUTO_PUSHD"         # cd pushes old dir onto the stack
      "PUSHD_SILENT"       # push silently
      "PUSHD_TO_HOME"      # pushd with no args → pushd $HOME
      "PUSHD_IGNORE_DUPS"  # don't push the same dir twice

      # Other
      "CORRECT_ALL"          # spelling correction for commands and args
      "EXTENDED_GLOB"        # treat #, ~, ^ as glob patterns
      "NOMATCH"              # error if glob has no matches
      "INTERACTIVE_COMMENTS" # allow # comments in interactive shell
      "LONG_LIST_JOBS"       # display PID when suspending processes
      "NOTIFY"               # report background job status immediately
      "HASH_LIST_ALL"        # hash entire command path on completion
      "COMPLETE_IN_WORD"     # complete not just at end of word
      "NO_HUP"               # don't SIGHUP background jobs on exit
      "NO_BEEP"              # no beep
    ];

    shellAliases = {
      mkcd = "mkdir --parents $1 && cd $1";
      dot  = "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
    };

    initContent = ''
      compdef dot=git # enable git completions for the dot alias
      source "${config.xdg.configHome}/zsh/functions.sh"
    '';
  };
}
