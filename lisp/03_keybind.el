;; keyset
(bind-key "C-h" 'backward-delete-char) ;C-h as BackSpace
(bind-key "M-?" 'help-for-help)        ;M-? as help
(bind-key "C-m" 'newline-and-indent)
(bind-key "M-g" 'goto-line)
(bind-key "C-^" 'next-error)


(use-package multiple-cursors
             :bind (
                    ("C->" . mc/mark-next-like-this)
                    ("C-<" . mc/mark-previous-like-this)
                    ("M-R" . mc/mark-all-dwim)
                    ("C-M-c" . mc/edit-lines)
                    ("C-M-r" . mc/mark-all-in-region)
                    )
             :config
             ;; multiple-cursorsの設定
  )

;; font size zoom
(if (and (>= emacs-major-version 23) (window-system))
    (progn
      (bind-key
       (vector (list 'control mouse-wheel-down-event))
       'text-scale-increase)
      (bind-key
       (vector (list 'control mouse-wheel-up-event))
       'text-scale-decrease)))


(provide '03_keybind)
