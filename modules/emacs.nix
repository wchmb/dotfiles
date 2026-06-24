{ config, pkgs, lib, ... }:

{
  programs.emacs = {
    enable  = true;
    package = pkgs.emacs.override {
      withNativeCompilation = true;
      withImageMagick       = true;
    };
    extraPackages = epkgs:
    let
      myTreesitGrammars = epkgs.treesit-grammars.with-grammars (grammars: [
        grammars.tree-sitter-c
        grammars.tree-sitter-cpp
        grammars.tree-sitter-python
        grammars.tree-sitter-nix
        grammars.tree-sitter-elisp
        grammars.tree-sitter-org
        grammars.tree-sitter-bash
        grammars.tree-sitter-json
        grammars.tree-sitter-toml
        grammars.tree-sitter-yaml
        grammars.tree-sitter-cmake
        grammars.tree-sitter-make
        grammars.tree-sitter-nasm
      ]);
    in
    with epkgs; [
      #treesit-grammars.with-all-grammars
      myTreesitGrammars
      vterm
      mu4e
    ];
  };

  home.packages = with pkgs; [
    # Doom required
    ripgrep
    fd
    git
    gnutls            # TLS for email/packages
    zstd              # undo-fu-session compression

    # macOS helpers
    coreutils         # gls, gcp
    gnused            # gsed (macOS 15 workaround)

    # Fonts
    fontconfig        # font detection
    et-book
    symbola
    nerd-fonts.symbols-only
    nerd-fonts.fira-mono

    # Module deps
    # :tools lookup & :lang org +roam
    sqlite            # org-roam, :tools lookup
    graphviz          # org visualizations
    # :lang cc
    clang-tools
    # :checkers spell
    # (aspellWithDicts (ds: with ds; [ en en-computers es ]))
    (hunspell.withDicts (dicts: with dicts; [ en-us es-es ]))
    # :lsp +booster
    emacs-lsp-booster
    # :email mu43
    mu
    isync
    msmtp
  ];

  fonts.fontconfig.enable = true;

  home.sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];

  home.sessionVariables = {
    LANG = "en_US.UTF-8"; # Hunspell uses LANG to determine the default dictionary
  };
}
