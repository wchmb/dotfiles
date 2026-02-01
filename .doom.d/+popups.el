;;; +popups.el -*- lexical-binding: t; -*-

;;; :ui poup
;; Do not hide modeline in popups
;; https://github.com/doomemacs/doomemacs/blob/master/modules/ui/popup/README.org#disabling-hidden-mode-line-in-popups
(remove-hook! '+popup-buffer-mode-hook #'+popup-set-modeline-on-enable-h)

;; Popup rule for compilation buffers
(set-popup-rule!
  "^\\*compilation\\*"
  :slot 1 :vslot -2 :size 0.3
  :autosave t
  :ttl 5
  :quit t    ; Dont quit on ESC
  :select nil) ; Dont focus automatically
