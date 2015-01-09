;; いつもの設定一覧

;; テーマ
;; monokai theme
(use-package monokai-theme
  :ensure monokai-theme
  :config
  (progn (load-theme 'monokai t)))


;; vc-mode は使わない
;;(setq vc-handled-backends ())

;;When pushing [TAB]
(setq-default indent-tabs-mode nil)

;; タブサイズ
(setq-default tab-width 4)

;; 左右分割を拒否
(setq split-width-threshold nil)

;; 滑らかなスクロール
(setq redisplay-dont-pause t)

;; 対応するカッコを強調表示
(show-paren-mode t)

;; 行間を指定
(setq-default line-spacing 0.2)

;; 見出し行番号表示
(global-set-key [f9] 'linum-mode)

;; モードライン関連
(column-number-mode 1)

;; erase memubar, scrollbar
;;画面上に出るツールバー(アイコン画像)を消す
(tool-bar-mode -1)
;;画面横に出るスクロールバーを消す
(scroll-bar-mode -1)
;;スプラッシュ(起動画面)抑止
(setq inhibit-startup-message t)

;; yes/no を y/n へ簡略化
(fset 'yes-or-no-p 'y-or-n-p)

;; scratchのメッセージ表示をしない
(setq initial-scratch-message "")

;; auto-complete
(use-package auto-complete-config
  :diminish auto-complete-mode
  :init (ac-config-default)
  :config
  (progn
    (bind-key "C-s" 'ac-isearch ac-completing-map)
    (setq ac-comphist-file "~/.emacs.d/.ac-comphist.dat")))


;; settings for text file
(use-package font-lock
  :commands font-lock-mode
  :init
  (add-hook 'text-mode-hook 'font-lock-mode)
  :config
  (font-lock-fontify-buffer)
  )


;; Emacs server configuration
;; Allows use with screen
;; Start either gnuserv or emacsserver for external access
(use-package server
  :config
  (progn
	(setq server-socket-dir
		  (format "%semacs%d"
				  temporary-file-directory
				  (user-uid)))
	(setq server-use-tcp 't))
  :idle 
  (progn	
	(unless (server-running-p)
	  (server-start))))


;; 前回編集していた場所を記憶し，ファイルを開いた時にそこへカーソルを移動
(use-package saveplace
  :defer
  :idle (setq-default save-place t)
  :init
  ;; tmp file saving directory
  (setq auto-save-list-file-prefix "~/.emacs.d/saves/.saves-")
  ;; backup.file~ location
  (setq make-backup-files t)
  (setq backup-directory-alist
		(cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
			  backup-directory-alist))
  :config
  )

;; recentf
(use-package recentf
  :commands recentf-mode
  :idle (recentf-mode t)
  :config (setq-default recentf-max-saved-items 10000))



;; undo/redo
(use-package undo-tree
  :bind
  (("C-M-/" . undo-tree-redo)
   ("C-/" . undo-tree-undo)
   )
  :init
  (progn
	(defalias 'redo 'undo-tree-redo)
	(defalias 'undo 'undo-tree-undo)
	)
  :config (global-undo-tree-mode)
  )


;; リンクの設定
(use-package w32-symlinks
  :if nt-p
  :idle
  (setq w32-symlinks-handle-shortcuts t)
  :config
  (setq w32-get-true-file-attributes nil)
  )
;; cygwin
(use-package cygwin-mount
  :if nt-p
  :commands (cygwin-mount-activate)
  :config
  ;; cygwin-mountの設定
  (setq find-dired-find-program "c:\\cygwin\\bin\\find.exe")
  (setq find-program "c:\\cygwin\\bin\\find.exe")
  (setenv "CYGWIN" "nodosfilewarning")
  )

;;C/Migemo
(use-package migemo
  :if (executable-find "cmigemo")
  :commands migemo-toggle-isearch-enable
  :config
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary
		(expand-file-name "~/.emacs.d/dict/utf-8/migemo-dict"))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  ;;(load-library "migemo")
  (migemo-init)
  )

(when windows-p
  ;; try to improve slow performance on windows.
  (setq w32-get-true-file-attributes nil)
  )

(when cygwin-p
  ;; Clipboard関連
  (global-set-key "\C-cw" 'cb-copy)
  (global-set-key "\C-cy" 'cb-paste)
  (defun cb-copy ()
    (interactive)
    (let ((coding-system-for-write 'shift_jis-dos))
      (shell-command-on-region
       (region-beginning)
       (region-end)
       "cat > /dev/clipboard" nil nil nil))
    (message ""))
  (defun cb-paste ()
    (interactive)
    (let ((coding-system-for-read 'shift_jis-dos))
      (goto-char
       (+ (point) (cadr (insert-file-contents "/dev/clipboard"))))))

  (set-clipboard-coding-system 'japanese-shift-jis-dos)
  )

(provide '02_enviroment)
