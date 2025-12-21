;;; +bindings.el -*- lexical-binding: t; -*-

(map! :leader
      (:prefix "f"
       :desc "Find alternate (.h/.c)" "a"  #'ff-find-other-file))

;; Bind C-w as the window switching prefix in insert mode
(map! :i "C-w" evil-window-map   ; Usually defaults to `evil-delete-backward-word'
      ;; Must explicitly override the higher-priority vterm/eshell maps
      (:after vterm
       :map vterm-mode-map
       :i "C-w" evil-window-map)
      (:after eshell
       :map eshell-mode-map
       :i "C-w" evil-window-map))

(map! :map dired-mode-map
      :nv "e" #'~/ediff-files)

(map! (:after evil-org
       :map evil-org-mode-map
       :n "gk" #'org-backward-heading-same-level
       :n "gj" #'org-forward-heading-same-level
       :localleader
       (:prefix ("r" . "refile")
                "r" #'org-refile-reverse
                "R" #'org-refile))) ; to all `org-refile-targets'

(map! (:when (modulep! :app rss)
        :leader
        (:prefix "o"
         :desc "RSS" "S" #'=rss))
      (:after elfeed-score
       :map elfeed-search-mode-map
       :nvi "=" elfeed-score-map))
