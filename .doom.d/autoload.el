;;; autoload.el -*- lexical-binding: t; -*-

;;;###autoload
;; From https://oremacs.com/2017/03/18/dired-ediff/
(defun +abm/dired-ediff-files ()
  "Ediff marked files from Dired."
  (interactive)
  (let ((files (dired-get-marked-files))
        (wnd (current-window-configuration)))
    (if (<= (length files) 2)
        (let ((file1 (car files))
              (file2 (cadr files)))
          ;; ediff in chronological order
          (if (file-newer-than-file-p file1 file2)
              (ediff-files file2 file1)
            (ediff-files file1 file2))
          ;; Restore previous window config after quit
          (add-hook! 'ediff-after-quit-hook-internal
            (lambda ()
              (setq! ediff-after-quit-hook-internal nil)
              (set-window-configuration wnd))))
      (error "no more than 2 files should be marked"))))


;;;###autoload
;; Support Git bare repos
;; https://github.com/magit/magit/issues/460#issuecomment-1475082958
(defun +abm/magit-process-environment (env)
  "Detect and set git -bare repo env vars when in tracked dotfile directories."
  (let* ((default (file-name-as-directory (expand-file-name default-directory)))
         (git-dir (expand-file-name "~/.dotfiles/"))
         (work-tree (expand-file-name "~/"))
         (dotfile-dirs
          (-map (apply-partially 'concat work-tree)
                (-uniq (-keep #'file-name-directory
                              (split-string (shell-command-to-string
                                             (format "/usr/bin/git --git-dir=%s --work-tree=%s ls-tree --full-tree --name-only -r HEAD"
                                                     git-dir work-tree))))))))
    (push work-tree dotfile-dirs)
    (when (member default dotfile-dirs)
      (push (format "GIT_WORK_TREE=%s" work-tree) env)
      (push (format "GIT_DIR=%s" git-dir) env)))
  env)
