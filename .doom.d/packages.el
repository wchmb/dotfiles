;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)
(package! nyan-mode)   ; Nyan cat indicates your buffer position
(package! auto-dark)   ; follow your OS's dark mode setting
(package! prodigy)     ; handle your services
(package! org-roam-ui) ; org-roam frontend
;; (package! rainbow-delimiters) ; https://github.com/orgs/doomemacs/projects/5/views/1?pane=issue&itemId=117610828
;; (package! good-scroll) ; smooth scroll: based on built-in pixel-scroll-mode
;; (package! gptel)       ; LLM client
;; (package! aidermacs)   ; aider (AI pair programming)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/radian-software/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))
;;(package! empvl
;;  ;; Requires mpv and yt-dlp
;;  :recipe (:host github :repo "isamert/empv.el")
;;(package! mentor
;;  ;; Requires rtorrent
;;  :recipe (:host github :repo "skangas/mentor")
;; (package! poke-line
;;   :recipe (:host github :repo "RyanMillerC/poke-line"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))
;; (package! aider
;;   :recipe (:host github :repo "tninja/aider.el"
;;            :files ("aider.el" "aider-doom.el"))) ; aider (AI pair programming)
;; TODO aidermacs now in melpa
;; (package! aidermacs  ; aider (AI pair programming)
;;  :recipe (:host github :repo "MatthewZMD/aidermacs" :files ("*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)
;; TODO Restart Emacs and try again, reply after https://github.com/doomemacs/doomemacs/issues/8263#issuecomment-2703366067
;;(package! solaire-mode :disable t)
(package! mu4e-alert :disable t) ; Dont notify new emails

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see radian-software/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
