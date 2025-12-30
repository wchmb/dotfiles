;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq! user-full-name "Alejandro Blasco"
       user-mail-address "alebdm@icloud.com")

;;;
;;; UI
;;;

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq! doom-font (font-spec :family "SF Mono" :size 14) ; Default font
       doom-variable-pitch-font (font-spec :family "American Typewriter") ; variable-pitch font (non-monospace)
       doom-serif-font (font-spec :family "SF Mono")) ; fixed-pitch font (monospace)

;; How many steps to in/decrease font size on `doom/increase-font-size'
(setq! doom-font-increment 1)

;; Trust lisp themes
;; https://emacs.stackexchange.com/questions/78979/emas-on-windows-gives-a-warning-when-loading-theme-can-run-lisp-code
(setq! custom-safe-themes t)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; Add all modus customizations prior to loading the theme!
(setq! modus-themes-bold-constructs t
       modus-themes-italic-constructs t
       modus-themes-mixed-fonts t
       modus-themes-variable-pitch-ui t
       modus-themes-custom-auto-reload t
       modus-themes-prompts '(italic bold)
       modus-themes-completions
       '((matches . (extrabold))
         (selection . (semibold text-also)))
       modus-themes-headings
       '((1 . (1.3))
         (2 . (1.2))
         (agenda-date . (1.2))
         (agenda-structure . (variable-pitch light 1.5))
         (t . (1.1))) ; Rest of headings
       modus-vivendi-palette-overrides '((bg-main "#1d2021") (bg-dim "#333637")) ; Not so dark
       modus-operandi-palette-overrides '((bg-main "#ffffe8") (bg-dim "#e5e5d0")) ; Acme's yellow-ish
       ;; Make line number and fringe as background
       modus-themes-common-palette-overrides
       '((bg-line-number-inactive bg-main)
         (bg-line-number-active bg-cyan-intense)
         (bg-prose-block-delimiter bg-main)
         (fg-prose-code unspecified)
         (bg-prose-code bg-prose-block-contents)
         (fg-prose-verbatim magenta-intense)
         (fringe bg-main)
         (corfu-default bg-main))) ; Default is bg-dim: https://github.com/protesilaos/modus-themes/blob/main/modus-themes.el#L2051

(setq! doom-theme 'modus-operandi)

;; Relative line numbers for knowing how far away line numbers are,
;; then ESC 12 <j/k> gets you exactly where you think
(setq! display-line-numbers-type 'relative)

;; Display vertical sroll bars
(scroll-bar-mode t)

;; Maximize frame initially
;; https://emacs.stackexchange.com/questions/2999/how-to-maximize-my-emacs-frame-on-start-up
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Slightly transparent frames by default
;; https://kristofferbalintona.me/posts/202206071000/
;; M-x doom/set-frame-opacity ; Change current frame opacity interactively
(set-frame-parameter nil 'alpha 90) ; For current frame
(add-to-list 'default-frame-alist '(alpha . 90)) ; For all new frames henceforth

;; Disable menu-bar (items are concealed with the notch)
;; https://discourse.doomemacs.org/t/how-to-disable-menu-bar-in-macos/4526/2
(menu-bar-mode 0)

;; Disable confirmation on exit
;; https://github.com/hlissner/doom-emacs/issues/2688
(setq! confirm-kill-emacs nil)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;;
;;; Modules
;;;

;;; Buit-ins
(after! dired

;; https://laurencewarne.github.io/emacs/programming/2022/12/26/exploring-proced.html
(use-package! proced
  :defer t
  :custom
  (proced-auto-update-flag t)
  (proced-auto-update-interval 10)
  (proced-goal-attribute nil)
  (proced-show-remote-processes t)
  (proced-enable-color-flag t)
  (proced-process-tree t)
  (proced-format 'mycustom)
  :config
  (defun abm/proced-command-basename (args)
    "Format process arguments to show only the basename of the command."
    (when args
      (let* ((fullpath (split-string args))
             (basename (car fullpath)))
        (file-name-nondirectory basename))))
  (setf (alist-get 'args proced-grammar-alist)
        '("Process"
          abm/proced-command-basename
          left
          proced-string-lessp
          nil
          (args pid)
          (nil t nil)))
  ;; mycustom is my proced-format (see `proced-gramar-alist')
  (add-to-list
   'proced-format-alist
   '(mycustom user pid ppid sess tree pcpu pmem rss start time state (args comm))))
(defalias 'top #'proced)

;;; :core
(use-package! which-key
  :init
  (setq! which-key-idle-delay 0.1) ; Faster popup. Must be set before mode activates.
  :config
  ;; Remove "evil-" prefix, it's too verbose
  (setq! which-key-allow-multiple-replacements t)
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◀\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◁\\1"))))


;;; :ui doom-dashboard
;; Screen for dashboard
(setq! fancy-splash-image (concat doom-private-dir "iamdoom.png"))
;; Remove dashboard sections
;; https://discourse.doomemacs.org/t/how-to-change-your-splash-screen/57#addremove-sections-of-the-dashboard-1
(remove-hook! '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu #'doom-dashboard-widget-footer)

;;; :ui modeline
(after! doom-modeline
  (setq! doom-modeline-buffer-file-name-style 'relative-to-project ; src/module/code.c
         ;; doom-modeline-persp-name t ; Display workspace (perpective)
         doom-modeline-major-mode-icon t) ; Display major-mode icon
  ;; Doom adds a hook to enable filesize. I don't care
  (remove-hook! 'doom-modeline-mode-hook #'size-indication-mode)
  ;; Do not hide modeline in popups
  ;; https://github.com/doomemacs/doomemacs/blob/master/modules/ui/popup/README.org#disabling-hidden-mode-line-in-popups
  (remove-hook! '+popup-buffer-mode-hook #'+popup-set-modeline-on-enable-h))

;;; :ui tabs
(after! centaur-tabs
  ;; Tabs style
  (setq! centaur-tabs-style "bar"
         centaur-tabs-set-bar nil
         centaur-tabs-height 13)
  (centaur-tabs-mode t))

;;; :term
;; Show modeline in eshell and vterm modes (hooks added in their own module's config)
(after! eshell
  (remove-hook! 'eshell-mode-hook #'hide-mode-line-mode))
(after! vterm
  (remove-hook! 'vterm-mode-hook #'hide-mode-line-mode))

;;; :tools llm
(after! gptel
  ;; Set with: security add-generic-password -s perplexity-api -a alebdm -w
  ;; API Keys: https://www.perplexity.ai/account/api/keys
  (defun abm/get-llm-api-key ()
    "Get Perplexity API key from macOS Keychain."
    (let ((command "security find-generic-password -s perplexity-api -a alebdm -w"))
      (replace-regexp-in-string "\n\\'" "" (shell-command-to-string command))))
  (setq! gptel-model   'sonar
         gptel-backend (gptel-make-perplexity "Perplexity"
                         :key #'abm/get-llm-api-key
                         :stream t))

;;; :tools lsp +eglot
(after! eglot
  (set-eglot-client! 'cc-mode '("clangd" "-j=3" "--clang-tidy"))) ; Use clangd

;;; :tools magit
(after! magit
  (advice-add 'magit-process-environment
              :filter-return #'+abm/magit-process-environment))

;;; :lang cc
(after! cc-mode
  ;; Underscore is part of the word in C buffers
  ;; https://evil.readthedocs.io/en/latest/faq.html#underscore-is-not-a-word-character
  (add-hook! 'c-mode-common-hook (lambda () (modify-syntax-entry ?_ "w"))))
;; TODO not working
(after! (:and cc-mode evil-nerd-commenter)
  ;; C-style single line comments
  (add-hook! 'c-mode-common-hook :append (lambda () (setq! comment-start "// "
                                                           comment-end ""))))

;;; :lang org
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq! org-directory "~/org/")
(after! org
  (setq! org-log-done 'time ; Record the time when an element is marked DONE
         org-startup-with-inline-images t)) ; Display images

;; +pretty
(after! org-modern
  (setq! org-modern-star 'replace
         org-modern-replace-stars "◉○✸✧■□"
         org-modern-timestamp nil
         org-modern-table nil
         org-modern-priority '((?A . "🔥🔥🔥")
                               (?B . "🔥🔥")
                               (?C . "🔥"))
         org-modern-progress nil
         org-modern-list nil
         org-modern-checkbox nil
         org-modern-horizontal-rule nil
         org-modern-todo nil
         org-modern-tag nil
         org-modern-block-name nil
         org-modern-keyword nil))
;; +pretty
(after! org-appear
  (setq! org-appear-autolinks 'just-brackets)) ; Show links with brackets around them. Hide link target
;; +dragndrop
(after! org-download
  (add-hook! 'dired-mode-hook 'org-download-enable)
  (setq! org-download-image-dir "~/org/pics/"
         org-download-screenshot-method "screencapture -i %s"))
;; Roam UI
(use-package! websocket
  :after org-roam)
(use-package! org-roam-ui
  :after org-roam
  ;; Normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;; a hookable mode anymore, you're advised to pick something yourself
  ;; If you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq! org-roam-ui-sync-theme t
         org-roam-ui-follow t
         org-roam-ui-update-on-save t
         org-roam-ui-open-on-start t))

;;; :email mu4e
(after! mu4e
  (setq! mu4e-mu-binary (or (executable-find "mu") "/opt/homebrew/bin/mu")
         mu4e-update-interval 300 ; Automatic fetching
         ;; Tweak when mu4e should guess or ask the correct context
         mu4e-context-policy 'pick-first
         mu4e-compose-context-policy 'ask)
  (setq! sendmail-program (or (executable-find "msmtp") "/opt/homebrew/bin/msmtp")
         message-sendmail-f-is-evil t
         message-sendmail-extra-arguments '("--read-envelope-from") ; Choose the SMTP server according to the from field
         message-send-mail-function #'message-send-mail-with-sendmail)
  ;; iCloud
  (set-email-account!
   "icloud"
   '((user-full-name         . "Alejandro Blasco")
     (smtpmail-smtp-user     . "alebdm@icloud") ; Required for sending mail
     (mu4e-compose-signature . "\nAlejandro\nalebdm@icloud.com")
     (mu4e-sent-folder       . "/icloud/Sent")
     (mu4e-drafts-folder     . "/icloud/Drafts")
     (mu4e-trash-folder      . "/icloud/Trash")
     (mu4e-refile-folder     . "/icloud/Refile"))
   t) ; Default/fallback account
  ;; Gmail
  (set-email-account!
   "gmail"
   '((user-full-name         . "Alejandro Blasco")
     (smtpmail-smtp-user     . "alejandro@fasts3.io") ; Required for sending mail
     (mu4e-compose-signature . "\nAlejandro\nalejandro@fasts3.io")
     (mu4e-sent-folder       . "/gmail/Sent")
     (mu4e-drafts-folder     . "/gmail/Drafts")
     (mu4e-trash-folder      . "/gmail/Trash")
     (mu4e-refile-folder     . "/gmail/Refile")))
  ;; Apply special integrations to the Google account
  (setq! +mu4e-gmail-accounts '(("alejandro@fasts3.io" . "/gmail"))) ; Set email and maildir
  ;; Bookmarks
  (add-to-list 'mu4e-bookmarks
               '("maildir:/icloud/INBOX" "Inbox - iCloud" ?i) t)
  (add-to-list 'mu4e-bookmarks
               '("maildir:/gmail/INBOX" "Inbox - Google" ?g) t)
  ;; Cc/Bcc headers
  (add-hook! 'mu4e-compose-mode-hook
    (defun abm/mu4e-add-cc-bcc-headers ()
      (save-excursion (message-add-header "Cc:\n"))
      (save-excursion (message-add-header "Bcc:\n")))))

;;; :app rss
(after! elfeed
  (setq! elfeed-search-filter "@2-week-ago +unread -rust -youtube -news -yak")
  (add-hook! 'elfeed-search-mode-hook #'elfeed-update)) ; Update feeds when opening

(use-package! elfeed-score
  :after elfeed
  :config
  (elfeed-score-load-score-file (concat org-directory "elfeed.score"))

;;; :config default
;; Always return `man' for documentation lookup
(defun +default/man-or-woman ()
  (interactive)
  (call-interactively #'man))
(after! man
  ;; Make the manpage the current buffer in the other window (default friendly)
  ;; https://github.com/emacs-mirror/emacs/blob/master/lisp/man.el
  (setq! Man-notify-method 'aggressive))

;;;
;;; Packages
;;;

(use-package! auto-dark
  ;; Based on https://github.com/LionyxML/auto-dark-emacs#doom-emacs
  ;; and https://github.com/doomemacs/doomemacs/issues/6424
  :hook (doom-init-ui . auto-dark-mode)
  :custom
  (auto-dark-allow-osascript t)
  (auto-dark-allow-powershell nil)
  (auto-dark-themes '((modus-vivendi) (modus-operandi))))

(use-package! dimmer
  :custom
  (dimmer-fraction 0.2) ; Slightly dim inactive buffers
  :init
  (dimmer-configure-which-key) ; Do not dim which-key popups
  (dimmer-mode t))

(use-package! nyan-mode
  :after doom-modeline
  :init (nyan-mode))

(load! "+bindings")
(load! "+popups")
(load! "+faces")
(load! "+secret" nil t)
