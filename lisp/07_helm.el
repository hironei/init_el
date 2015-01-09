;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; helm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm
  :diminish helm-mode
  :bind
  (("M-x"     . helm-M-x)
   ("C-x C-b" . malb/helm-omni)
   ("C-x C-f" . helm-find-files)
   ("M-r" . helm-resume)
   ("C-;" . helm-imenu)
   ("C-:" . helm-occur)
   ("C-x ;" . helm-mini)
   ("M-y" . helm-show-kill-ring)
   ("C-x C-b" . helm-buffers-list)
   ("C-S-f" . helm-ag)
   )
  :config
  (progn
    (bind-key "C-h" 'delete-backward-char helm-map)

    (use-package helm-config)
    (use-package helm-cmd-t
      :config
      ;;(add-to-list 'helm-cmd-t-repo-types '("gtags" "" gtags-find-file))
      )
    (use-package helm-C-x-b
      :bind ("C-x b" . helm-C-x-b)
      )
    (use-package helm-c-moccur
      :bind
      (("M-o" . helm-c-moccur-occur-by-moccur)
       ("C-M-o" . helm-c-moccur-dmoccur)
       ("C-M-s" . helm-c-moccur-isearch-forward)
       ("C-M-r" . helm-c-moccur-isearch-backward)
       )
      :init
      (use-package dired
        ;;:bind ("O" . helm-c-moccur-dired-do-moccur-by-moccur )
        )
      )
    (custom-set-variables
     '(helm-mode t)
     ;; '(helm-use-migemo t) ;; 一時的にコメントアウト
     '(helm-command-prefix-key "C-z")
     '(helm-ff-auto-update-initial-value nil) ;;; 自動補完を無効
     '(helm-truncate-lines t)
     '(helm-buffer-max-length 35)
     '(helm-delete-minibuffer-contents-from-point t)
     '(helm-ff-skip-boring-files t)
     '(helm-boring-file-regexp-list '("~$" "\\.elc$"))
     '(helm-grep-default-command "lgrep +i -n%c -Au8 -Ia - %p %f /dev/null")
     '(helm-grep-default-recurse-command
       (concat "find %f -type d \\( -name '.svn' -o -name '.git' \\) -prune "
               "-o -type f -name `echo -n '%e' | sed 's/--include=//' "
               "| sed 's/--exclude.*//' | sed 's/\\\\\\\\//g'` -print0 "
               "| xargs -0 lgrep +i -n%c -Au8 -Ia - %p /dev/null"))
     ;;   '(helm-ls-git-show-abs-or-relative 'relative)
     '(helm-mini-default-sources
       '(
         ;;helm-source-moccur
         ;;helm-source-occur  ;; ?
         helm-source-buffers-list
         helm-source-recentf
         ;;helm-source-browse-code
         ;;helm-source-locate
         helm-source-bookmarks
         helm-source-files-in-current-dir
         helm-source-buffer-not-found
         ))
     ;; '(helm-ag-base-command "ag --nocolor --nogroup --ignore-case")
     ;; '(helm-ag-command-option "--all-text")
     ;; '(helm-ag-thing-at-point 'symbol)
     ;; '(helm-gtags-path-style 'relative)
     ;; '(helm-gtags-ignore-case t)
     '(enable-recursive-minibuffers t)
     )))



(provide '07_helm)
