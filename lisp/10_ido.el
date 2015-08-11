(use-package ido
  :bind (
         ("C-;" . ido-imenu-anywhere)
         )
  :init
  (progn
    (ido-mode 1)
    (ido-everywhere 1))
  :config
  (progn
    (setq ido-case-fold t)
    (setq ido-everywhere t)
    (setq ido-enable-prefix nil)
    (setq ido-enable-flex-matching t)
    (setq ido-create-new-buffer 'always)
    (setq ido-max-prospects 10)
    (setq ido-use-faces nil)
    (setq ido-file-extensions-order '(".py" ".el" ))
    (add-to-list 'ido-ignore-files "\\.DS_Store"))
  )

(use-package nyan-mode
  :init (nyan-mode 1))

(use-package smex
  :init (smex-initialize)
  :bind ("M-x" . smex)
  )

(provide '10_ido)

