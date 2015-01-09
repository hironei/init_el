;; LOG
(use-package compilation-minor-mode
  :mode
  (("\\.log$" . compilation-minor-mode)
   ("\\.err$" . compilation-minor-mode))
  :config
  )

;; INI/BAT
(use-package generic-x
  :mode
  (("\\.ini$" . ini-generic-mode)
   ("\\.bat$" . bat-generic-mode))
  )

;; gtags-mode を使いたい mode の hook に追加する
;; cc-mode
(use-package cc-mode
  :mode (("\\.c$" . c-mode)
         ("\\.h$" . c-mode)
         ("\\.cpp" . c++-mode)
         )
  :init
  (add-hook 'c-mode-hook (lambda () (c-set-style "stroustrup")))
  (add-hook 'java-mode-hook (lambda () (c-set-style "stroustrup")))  
  :config
  (setq tab-width 4)
  (setq c-basic-offset 4)
  (setq indent-tabs-mode t)
  (c-toggle-hungry-state nil)
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  )


(use-package gtags
  :init
  (progn
    (add-hook 'c-mode-hook (lambda () (gtags-mode t)))
    (setq gtags-path-style 'relative)
    (setq gtags-suggested-key-mapping t)
    (setq gtags-auto-update t)
    )
  :config
  (progn
    (bind-key "<mouse-2>" 'gtags-find-tag-from-here gtags-mode-map)
    (setq gtags-mode-hook
          '(lambda ()
             (local-set-key "M-t" 'gtags-find-tag)
             (local-set-key "M-r" 'gtags-find-rtag)
             (local-set-key "M-s" 'gtags-find-symbol)
             (local-set-key "C-t" 'gtags-pop-stack)
             ))
    
    ;; (use-package helm-gtags
    ;;   :bind (
    ;;          ("M-l" . helm-gtags-select)
    ;;          ("M-t" . helm-gtags-find-tag)
    ;;          ("M-r" . helm-gtags-find-rtag)
    ;;          ("M-s" . helm-gtags-find-symbol)
    ;;          ("C-t" . helm-gtags-pop-stack)
    ;;          )
    ;;   :config
    ;;   (bind-key "m-," 'helm-gtags-resume gtags-mode-map))
    ;; )
    ))

;; python

;; jedi
(use-package jedi
  :commands jedi:setup
  :init
  (progn
    (add-hook
     'python-mode-hook
     (lambda ()
       (jedi:setup)
       )))
  :config
  (progn
    (setq jedi:setup-keys t)
    (setq jedi:complete-on-dot t)))

(defun python-shell-send-buffer-with-my-args (args)
  (interactive "Python arguments: ")
  (let ((source-buffer (current-buffer)))
    (with-temp-buffer
      (message args)
      (python-shell-send-buffer args))))
(bind-key "C-c C-a" 'python-shell-send-buffer-with-my-args)


;; plantuml
(use-package plantuml-mode
  :commands plantuml-mode
  :mode "\\.uml$"
  )

;; quickrun
(use-package quickrun
  :bind ("C-<f11>" . quickrun)
  )

(provide '09_lang)
