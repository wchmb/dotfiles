{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alejandro";
  home.homeDirectory = "/Users/alejandro";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
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
    FLAKE_CONFIG_URI = "path:${config.home.homeDirectory}/nix#homeConfigurations.${config.home.username}";
    # EDITOR = "emacs";
    HISTTIMEFORMAT        = "%F %T ";
    HOMEBREW_NO_ENV_HINTS = "1";
    SDKROOT = "\$(xcrun --sdk macosx --show-sdk-path)"; # Base SDK for building
  };

  # Extra directories to prepend to PATH.
  home.sessionPath = [
    "${config.home.homeDirectory}/.emacs.d/bin"
    "${config.home.homeDirectory}/.docker/bin"
    "${config.home.homeDirectory}/.local/bin"
    "/Library/Developer/CommandLineTools/usr/bin"
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
  };

  # Make programs use XDG directories whenever supported
  home.preferXdgDirectories = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
