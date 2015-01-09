;; WindowManager
;;(require 'e2wm)

;; color-moccur
;;color-moccurのお勧め設定。
(use-package color-moccur
             :commands
             (moccur-grep-find occur-by-moccur)
             :init
             (setq moccur-split-word t) ;スペース区切りでAND検索
             (setq moccur-use-migemo t) ;migemoを使う
             :config
             ;; moccur-edit
             (require 'moccur-edit)
             
             ;; moccur-grep-findで.svnを無視する
             (setq dmoccur-exclusion-mask
                   (append
                    '("\\~$" "\\.svn\\/\*" "bin\\/\*" "\\.jar$")
                    dmoccur-exclusion-mask))
             )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ag
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ag
             :init
             (autoload 'wgrep-ag-setup "wgrep-ag")
             (add-hook 'ag-mode-hook 'wgrep-ag-setup)
             :ensure t
             :defer t
             :config
             (progn
               (setq ag-highlight-search t)  ; 検索キーワードをハイライト
               (setq ag-reuse-buffers t)     ; 検索用バッファを使い回す (検索ごとに新バッファを作らない)
               (bind-key "n" 'compilation-next-error ag-mode-map)
               (bind-key "p" 'compilation-previous-error ag-mode-map)
               (bind-key "N" 'compilation-next-file ag-mode-map)
               (bind-key "P" 'compilation-previous-file ag-mode-map)
               (setq wgrep-auto-save-buffer t)  ; 編集完了と同時に保存
               (setq wgrep-enable-key "r")      ; "r" キーで編集モードに

               ))


(provide '06_tool)
