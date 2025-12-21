;;; +popups.el -*- lexical-binding: t; -*-

;; Popup rule for compilation buffers
(set-popup-rule!
  "^\\*compilation\\*"
  :slot 1 :vslot -2 :size 0.3
  :autosave t
  :ttl 5
  :quit t    ; Dont quit on ESC
  :select nil) ; Dont focus automatically
