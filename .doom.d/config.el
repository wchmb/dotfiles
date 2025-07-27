;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Alejandro Blasco"
      user-mail-address "alebdm@icloud.com")

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
(setq doom-font (font-spec
                 :family "SF Mono"
                 :size 14
                 :weight 'regular) ; Default font
      doom-variable-pitch-font (font-spec
                                :family "American Typewriter"
                                :size 14
                                :weight 'regular) ; For variable-pitch text a.k.a non-monospace
      doom-serif-font (font-spec
                       :family "SF Mono"
                       :size 14
                       :weight 'ultra-light)) ; For fixed-pitch text a.k.a monospace

;; How many steps to in/decrease font size on `doom/increase-font-size'
(setq doom-font-increment 1)

;; Trust lisp themes
;; https://emacs.stackexchange.com/questions/78979/emas-on-windows-gives-a-warning-when-loading-theme-can-run-lisp-code
(setq custom-safe-themes t)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
(load-theme 'doom-one t)
;; Protesilaos theme :) https://github.com/protesilaos/modus-themes
;;(setq doom-theme 'modus-vivendi)
;;(setq doom-theme 'modus-operandi)
;;(load-theme 'modus-operandi t) ; light
;;(load-theme 'modus-vivendi t) ; dark
(use-package! emacs
  :init
  (require-theme 'modus-themes) ; `require-theme' is ONLY for the built-in Modus themes
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-bold-constructs t
        modus-themes-italic-constructs t
        modus-themes-mixed-fonts t
        modus-themes-variable-pitch-ui t
        modus-themes-custom-auto-reload t
        modus-themes-headings
;;        '((1 . (variable-pitch 1.3))
        '((1 . (1.3))
          (2 . (1.2))
          (agenda-date . (1.2))
          (agenda-structure . (variable-pitch light 1.5))
          (t . (1.1)))) ; Style for all other headings
  (setq modus-vivendi-palette-overrides
        '((bg-main "#1d2021"))) ; Not so dark
  (setq modus-operandi-palette-overrides
        '((bg-main "#efefef"))) ; Not so bright
  :config)
  ;; Load the theme of your choice.
  ;;(load-theme 'modus-vivendi t)) ; Dark

;; Maximize Emacs frame on start-up
;; https://emacs.stackexchange.com/questions/2999/how-to-maximize-my-emacs-frame-on-start-up
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Screen for dashboard
(setq fancy-splash-image "~/Pictures/iam_doom.png")
;; Remove dashboard sections
;; https://discourse.doomemacs.org/t/how-to-change-your-splash-screen/57#addremove-sections-of-the-dashboard-1
(remove-hook! '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu #'doom-dashboard-widget-footer)

;; Display window separator
;; https://discourse.doomemacs.org/t/how-to-switch-customize-or-write-themes/37
;;(custom-set-faces! '(vertical-border :foreground "gray"))

;; Style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
;; (global-display-line-numbers-mode -1)
;; (dolist (mode '(text-mode-hook
;;                 prog-mode-hook))
;;   (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Display vertical sroll bars
(scroll-bar-mode t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Disable confirmation on exit
;; https://github.com/hlissner/doom-emacs/issues/2688
(setq confirm-kill-emacs nil)

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

(after! doom-modeline
  (setq doom-modeline-persp-name t ; Display workspace (perpective) name
        doom-modeline-major-mode-icon t) ; Display major-mode icon
  ;; Smaller font in modeline
  ;; TODO not working
  ;; https://github.com/seagle0128/doom-modeline/blob/master/README.md#faq
  (setq doom-modeline-height 1) ; Optional
  (if (facep 'mode-line-active)
      (set-face-attribute 'mode-line-active nil :height 80) ; For 29+
    (set-face-attribute 'mode-line nil :height 80))
  (set-face-attribute 'mode-line-inactive nil :height 80))

;; Show modeline in eshell and vterm modes (hooks added in their own module's config)
(after! eshell
  (remove-hook! 'eshell-mode-hook #'hide-mode-line-mode))
(after! vterm
  (remove-hook! 'vterm-mode-hook #'hide-mode-line-mode))

(after! dired
  (setq dired-kill-when-opening-new-dired-buffer t) ; Kill dired buffers immediately
  ;; Ediff marked files from Dired
  ;; https://oremacs.com/2017/03/18/dired-ediff/
  (defun abm--ediff-files-in-dired ()
    (interactive)
    (let ((files (dired-get-marked-files))
          (wnd (current-window-configuration)))
      (if (<= (length files) 2)
          (let ((file1 (car files))
                (file2 (if (cdr files)
                           (cadr files)
                         (read-file-name
                          "file: "
                          (dired-dwim-target-directory)))))
            (if (file-newer-than-file-p file1 file2)
                (ediff-files file2 file1)
              (ediff-files file1 file2))
            (add-hook 'ediff-after-quit-hook-internal
                      (lambda ()
                        (setq ediff-after-quit-hook-internal nil)
                        (set-window-configuration wnd))))
        (error "no more than 2 files should be marked"))))
  ;; TODO keymap not working
  (add-hook! 'dired-mode-hook
    (lambda() (define-key dired-mode-map (kbd "e") 'abm--ediff-files-in-dired))))

;; Underscore is part of the word in C buffers
;; https://evil.readthedocs.io/en/latest/faq.html#underscore-is-not-a-word-character
;(add-hook! 'c-mode-common-hook (lambda () (modify-syntax-entry ?_ "w")))
(after! cc-mode
  (add-hook! 'c-mode-common-hook (lambda () (modify-syntax-entry ?_ "w"))))

;; C-style single line comments
;; TODO not working
(after! (:and cc-mode evil-nerd-commenter)
  (add-hook! 'c-mode-common-hook :append (lambda () (setq comment-start "// "
                                                          comment-end ""))))

;; Tabs style
(after! centaur-tabs
  (setq centaur-tabs-style "bar"
        centaur-tabs-set-bar nil
        centaur-tabs-height 13)
  (centaur-tabs-mode t))

;; Configure Eglot with clangd
(after! eglot
  (set-eglot-client! 'cc-mode '("clangd" "-j=3" "--clang-tidy")))

;; Make the manpage the current buffer in the other window (default friendly)
;; https://github.com/emacs-mirror/emacs/blob/master/lisp/man.el
(after! man
  (setq Man-notify-method 'aggressive))

;; Display images
(after! org
  (setq org-startup-with-inline-images t))

;; Pretty org
(after! org-modern
  (setq org-modern-star 'replace)
  (setq org-modern-replace-stars "◉○✸✧■□")
  (setq org-modern-timestamp nil)
  (setq org-modern-table nil)
  (setq org-modern-priority
    '((?A . "🔥🔥🔥")
      (?B . "🔥🔥")
      (?C . "🔥")))
  (setq org-modern-list nil)
  (setq org-modern-checkbox nil)
  (setq org-modern-todo nil)
  (setq org-modern-tag nil)
  (setq org-modern-block-name nil)
  (setq org-modern-keyword nil))

;; Prefer "login" fieldname over "user". And more standard
;;(after! pass
;;  (setq pass-username-field "login"))

(after! gptel
  (setq! gptel-model 'gemini-2.5-pro-exp-03-25
         gptel-backend (gptel-make-gemini "Gemini"
                                          :key "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
                                          :stream t)))

(after! elfeed
  (setq! elfeed-search-filter "@1-week-ago +unread -rust -youtube -news -chatty")
  (add-hook! 'elfeed-search-mode-hook #'elfeed-update)) ; Update feeds when opening

(after! mu4e
  (setq mu4e-update-interval 300) ; Automatic fetching
  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail)
  (set-email-account! "icloud"
    '((user-full-name         . "Alejandro Blasco")
      (smtpmail-smtp-user     . "alebdm@icloud") ; Required for sending mail
      (mu4e-compose-signature . "\nAlejandro\nalebdm@icloud.com")
      (mu4e-sent-folder       . "/icloud/Sent Messages")
      (mu4e-trash-folder      . "/icloud/Deleted Messages")
      (mu4e-drafts-folder     . "/icloud/Drafts")
      (mu4e-refile-folder     . "/icloud/Archive"))
   t)
  (add-to-list 'mu4e-bookmarks
               '("maildir:/icloud/INBOX" "Inbox" ?i) t)
  (add-hook 'mu4e-compose-mode-hook
            (lambda ()
              (save-excursion (message-add-header "Cc:\n"))
              (save-excursion (message-add-header "Bcc:\n")))))



;; (use-package aider
;;   :config
;;   (setq aider-args '("--model" "gemini/gemini-2.0-pro-exp-02-05"))
;;   (setenv "GEMINI_API_KEY" "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"))

;; (use-package! aidermacs
;;   :config
;;   (setenv "GEMINI_API_KEY" "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
;;   ;; <leader> A A
;;   (map! :leader
;;         (:prefix ("A" . "aidermacs")
;;          :desc "Aider menu" "A" #'aidermacs-transient-menu)) ;; transitient menu (like magit)
;;   :custom
;;   (aidermacs-program "~/.local/bin/aider") ; installed with pipx
;;   ;;(aidermacs-default-model "gemini-2.0-pro-exp-02-05"))
;;   ;;(aidermacs-default-model "gemini/gemini-exp-1206")
;;   ;;(aidermacs-default-model "gemini/gemini-2.0-flash-thinking-exp-01-21"))
;;   (aidermacs-default-model "gemini/gemini-2.5-pro-exp-03-25"))


;; MPV frontend
;; More Invidious instances here https://api.invidious.io/
;; The URL should end with "/api/v1"
;;(use-package empv
;;  :defer t
;;  :custom
;;  (empv-invidious-instance "https://invidious.fdn.fr/api/v1"))

;; rTorrent frontend
;;(use-package mentor
;;  :defer t
;;  :custom
;;  (mentor-rtorrent-download-directory "~/Downloads")
;;  (mentor-rtorrent-keep-session t)
;;  :config
;;  (map! :map mentor-mode-map
;;        :n "k"   #'mentor-previous-item
;;        :n "j"   #'mentor-next-item
;;        :n "DEL" #'mentor-download-load-torrent
;;        :n "l"   #'mentor-download-load-magnet-link-or-url
;;        :n "s"   #'mentor-download-start
;;        :n "S"   #'mentor-download-stop
;;        :n "d"   #'mentor-download-remove
;;        :n "D"   #'mentor-download-remove-including-files
;;        :n "v"   #'mentor-dired-jump
;;        :n "q"   #'mentor-shutdown))

;; Built-in Htop
;; https://laurencewarne.github.io/emacs/programming/2022/12/26/exploring-proced.html
(use-package! proced
  :defer t
  :custom
  (proced-auto-update-flag t)
  (proced-goal-attribute nil)
  (proced-show-remote-processes t)
  (proced-enable-color-flag t)
  (proced-format 'custom)
  :config
  (add-to-list
    'proced-format-alist
    '(custom user pid ppid sess tree pcpu pmem rss start time state (args comm))))
(defalias 'htop 'proced)

(use-package! nyan-mode
  :after doom-modeline
  :init (nyan-mode))

;; Required to susbscribe changes in appearance via System Events
;; https://github.com/LionyxML/auto-dark-emacs/issues/13
;; Run: shell-command osascript -e 'tell application "System Events" to tell appearance preferences to return dark mode'
;; And then go to: Settings > Privacy > Automation > Emacs > System Events = YES
;; (setq auto-dark-allow-osascript t)
;; (after! doom-ui
;;   ;; Set your favorite themes
;;   ;;(setq! auto-dark-themes '((doom-one) (doom-one-light)))
;;   (setq! auto-dark-themes '((modus-vivendi) (modus-operandi)))
;;   (auto-dark-mode))
;;(use-package! auto-dark
;;;;TODO Deshabilitado temporalmente porque 'doom doctor' detecta un error de load theme
;;;;  :disabled
;;  :after doom-ui
;;  :init (auto-dark-mode)
;;  :config
;;  (setq! auto-dark-allow-osascript t)
;;  (setq! auto-dark-themes '((modus-vivendi) (modus-operandi)))) ;; Set your favorite themes

(use-package! auto-dark
  :after doom-ui
  :init (auto-dark-mode)
  :custom
  (auto-dark-themes nil)
  (auto-dark-allow-osascript t)
  (auto-dark-allow-powershell nil)
  :hook
  ;; (auto-dark-dark-mode . (lambda () (load-theme 'modus-vivendi t)))
  ;; (auto-dark-light-mode . (lambda () (load-theme 'modus-operandi t))))
  (auto-dark-dark-mode . (lambda () (load-theme 'doom-one t)))
  (auto-dark-light-mode . (lambda () (load-theme 'doom-one-light t))))

(use-package! websocket
  :after org-roam)
(use-package! org-roam-ui
  :after org-roam
;; Normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;; a hookable mode anymore, you're advised to pick something yourself
;; If you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

;; TODO Now this config is integrated in Doom
;; ultra-scroll take care of mouse and input device scrolling and good-scroll can be relegated to scrolling keyboard commands
;; https://github.com/io12/good-scroll.el/issues/28#issuecomment-1117887861
;;(use-package good-scroll
;; :hook (doom-first-input . good-scroll-mode)
;; :config
;; (defun good-scroll--convert-line-to-step (line)
;;   (cl-typecase line
;;     (integer (* line (line-pixel-height)))
;;     ((or null (member -))
;;      (- (good-scroll--window-usable-height)
;;         (* next-screen-context-lines (line-pixel-height))))
;;     (t (line-pixel-height))))
;;
;; (defadvice! good-scroll--scroll-up (&optional arg)
;;   :override 'scroll-up
;;   (good-scroll-move (good-scroll--convert-line-to-step arg)))
;;
;; (defadvice! good-scroll--scroll-down (&optional arg)
;;   :override 'scroll-down
;;   (good-scroll-move (- (good-scroll--convert-line-to-step arg)))))
;;
;; ;;TODO Unfinished remap evil-goto-line, follow conversation: https://github.com/doomemacs/doomemacs/issues/8335
;; ;; (defadvice! good-scroll--evil-goto-line (&optional arg)
;; ;;   :override #'evil-goto-line
;; ;;   (good-scroll-move (good-scroll--convert-line-to-step arg))))


;;;; TODO: REMOVE this since good-scroll works just fine
;; (use-package pixel-scroll
;;   :bind
;;   ([remap scroll-up-command]   . pixel-scroll-interpolate-down)
;;   ([remap scroll-down-command] . pixel-scroll-interpolate-up)
;;   :custom
;;   (pixel-scroll-precision-interpolate-page t)
;;   :init
;;   (pixel-scroll-precision-mode 1))

;; (use-package pixel-scroll
;;   :ensure nil
;;   :custom
;;   ;;Enable pixel-based vertical scroll instead of line-based
;;   (pixel-scroll-precision-interpolation-factor 1.0)
;;   :bind
;;   (([remap scroll-up-command]   . fk/pixel-scroll-up-command)
;;    ([remap scroll-down-command] . fk/pixel-scroll-down-command)
;;    ([remap recenter-top-bottom] . fk/pixel-scroll-recenter-top-bottom))
;;   :hook
;;   (dashboard-after-initialize . pixel-scroll-precision-mode)
;;   :config
;;   (defun fk/pixel-scroll-up-command ()
;;     "Similar to `scroll-up-command' but with pixel scrolling."
;;     (interactive)
;;     (pixel-scroll-precision-interpolate (- (* fk/default-scroll-lines (line-pixel-height)))))

;;   (defun fk/pixel-scroll-down-command ()
;;     "Similar to `scroll-down-command' but with pixel scrolling."
;;     (interactive)
;;     (pixel-scroll-precision-interpolate (* fk/default-scroll-lines (line-pixel-height))))

;;   ;; TODO: fix window position after scrolling is done
;;   ;; (run-at-time pixel-dead-time nil (lambda ()
;;   ;;                                    (unless (pixel-scroll-in-rush-p)
;;   ;;                                      (set-window-vscroll nil 0 t))))

;;   (defun fk/pixel-scroll-recenter-top-bottom ()
;;     "Similar to `recenter-top-bottom' but with pixel scrolling."
;;     (interactive)
;;     (let* ((current-row (cdr (nth 6 (posn-at-point))))
;;            (target-row (save-window-excursion
;;                          (recenter-top-bottom)
;;                          (cdr (nth 6 (posn-at-point)))))
;;            (distance-in-pixels (* (- target-row current-row) (line-pixel-height))))
;;       (pixel-scroll-precision-interpolate distance-in-pixels))))

;; <leader> f a : Find alternate .h/.cpp file
(map! :leader
  ;;; <leader> f --- file
  (:prefix-map ("f" . "file")
   :desc "Find alternate (h/c)" "a"  #'ff-find-other-file))
