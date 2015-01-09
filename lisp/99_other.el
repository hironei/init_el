(when windows-p
  ;; cygstart を使う
  (setq dired-guess-shell-alist-user
        '(("\\.png"   "start")
          ("\\.jpeg"  "start")
          ("\\.jpg"   "start")
          ("\\.gif"   "start")
          ("\\.tif"   "start")
          ("\\.tiff"  "start")
          ("\\.pdf"   "start")
          ;; MS Office
          ("\\.doc"   "start")
          ("\\.docx"  "start")
          ("\\.xls"   "start")
          ("\\.xlsx"  "start")
          ;; Archive
          ("\\.rar" "unrar x")
          ("\\.lzh" "lha x")
          ("\\.7z"  "7z x")
          ))

  ;; start を実行する (dired で "z")
  (defun dired-do-start ()
    "In dired, open with start."
    (interactive)
    (let ((files (dired-get-marked-files)))
      (dired-do-shell-command "start" nil files)))

                                        ; other window に コピー (dired で "c")
  (defun dired-copy-to-other-window (arg)
    "In dired, copy selected file(s) to the other window."
    (interactive "P")
    (let ((dired-dwim-target t))
      (dired-do-copy arg)))

                                        ; other window に 移動 (dired で "r")
  (defun dired-move-to-other-window (arg)
    "In dired, rename selected file(s) to the other window."
    (interactive "P")
    (let ((dired-dwim-target t))
      (dired-do-rename arg)))

  (when windows-p
    ;; Explorer で開く (dired で "E")
    (defun dired-exec-explorer ()
      "In dired, execute Explorer."
      (interactive)
      (explorer (dired-current-directory)))

    (defun unix-to-dos-filename (file)
      (with-temp-buffer
        (insert file)
        (goto-char (point-min))
        (while (search-forward "/" nil t)
          (replace-match "\\" nil t))
        (buffer-string)))

    (defun explorer (&optional dir)
      (interactive)
      (setq dir (expand-file-name (or dir default-directory)))
      (if (or (not (file-exists-p dir))
              (and (file-exists-p dir)
                   (not (file-directory-p dir))))
          (message "%s can't open." dir)
        (setq dir (unix-to-dos-filename dir))
        (let ((w32-start-process-show-window t))
          (apply (function start-process)
                 "explorer" nil "c:/Windows/explorer.exe" (list (concat "/e,/root," dir))))))

    ;; キー割り当て
    (add-hook 'dired-mode-hook
              '(lambda ()
                 (define-key dired-mode-map "c" 'dired-copy-to-other-window) ; copy to other window
                 (define-key dired-mode-map "r" 'dired-move-to-other-window) ; rename to other window
                 (define-key dired-mode-map "z" 'dired-do-start) ; do start
                 (define-key dired-mode-map "E" 'dired-exec-explorer) ; open with explorer
                 (define-key dired-mode-map "W" 'wdired-change-to-wdired-mode) ; wdired mode
                 ))
    )
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ユーティリティ関数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; uniq
(defun uniq-region (beg end)
  "Remove duplicate lines, a` la Unix uniq.
   If tempted, you can just do <<C-x h C-u M-| uniq RET>> on Unix."
  (interactive "r")
  (let ((ref-line nil))
    (uniq beg end 
          (lambda (line) (string= line ref-line)) 
          (lambda (line) (setq ref-line line)))))

(defun uniq-remove-dup-lines (beg end)
  "Remove all duplicate lines wherever found in a file, rather than
   just contiguous lines."
  (interactive "r")
  (let ((lines '()))
    (uniq beg end 
          (lambda (line) (assoc line lines))
          (lambda (line) (add-to-list 'lines (cons line t))))))

(defun uniq (beg end test-line add-line)
  (save-restriction
    (save-excursion
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (if (funcall test-line (thing-at-point 'line))
            (kill-line 1)
          (progn
            (funcall add-line (thing-at-point 'line))
            (forward-line))))
      (widen))))

(defun clipboard-to-buffer-file-name ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(defun clipboard-to-file-name ()
  "Put the current buffer name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

;; テンポラリバッファを作成し、それをウィンドウに表示します。
(defun create-temporary-buffer ()
  "テンポラリバッファを作成し、それをウィンドウに表示します。"
  (interactive)
  ;; *temp* なバッファを作成し、それをウィンドウに表示します。
  (switch-to-buffer (generate-new-buffer "*temp*"))
  ;; セーブが必要ないことを示します？
  (setq buffer-offer-save nil))
;; C-c t でテンポラリバッファを作成します。
(bind-key "C-x c t" 'create-temporary-buffer)

;; VC
;; lock
(defun svn-lock()
  (interactive)
  (vc-svn-command nil 0 buffer-file-name "lock")
  (revert-buffer t t t))
;; unlock
(defun svn-unlock()
  (interactive)
  (vc-svn-command nil 0 buffer-file-name "unlock")
  (revert-buffer t t t))

;; 時間挿入
(defun my-get-date-gen (form) (insert (format-time-string form)))
(defun my-get-date() (interactive) (my-get-date-gen "%Y/%m/%d"))
;; C-cC-dで時間挿入できるようにする
(bind-key "C-c d" 'my-get-date)


(provide '99_other)
