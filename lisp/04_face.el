;; for whitespace-mode
(use-package whitespace
             :bind
             (("C-x w" . global-whitespace-mode))
             :config
             ;; see whitespace.el for more details
             (setq whitespace-style 
                   '(face tabs tab-mark spaces space-mark newline newline-mark))
             (setq whitespace-display-mappings
                   '((space-mark ?\u3000 [?\u25a1]) ; 全角スペース
                     (space-mark ?\u0020 [?\xB7])  ; 半角スペース
                     ;; WARNING: the mapping below has a problem.
                     ;; When a TAB occupies exactly one column, it will display the
                     ;; character ?\xBB at that column followed by a TAB which goes to
                     ;; the next TAB column.
                     ;; If this is a problem for you, please, comment the line below.
                     (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
             (setq whitespace-space-regexp "\\(\u3000+\\)")
             (set-face-foreground 'whitespace-tab "#bebebe")
             (set-face-background 'whitespace-tab 'nil)
             (set-face-underline  'whitespace-tab 'nil)
             (set-face-foreground 'whitespace-space "#bebebe")
             (set-face-background 'whitespace-space 'nil)
             (set-face-bold-p 'whitespace-space t)
             )

;; elisp変数表示のとき途中で省略しない
(setq eval-expression-print-level nil)
(setq eval-expression-print-length nil)

;; フォント設定
(when nt-p
  ;; Font
  (set-frame-font "MeiryoKe_Console")
  (add-to-list 'default-frame-alist '(font . "MeiryoKe_Console"))
  )

(provide '04_face)
