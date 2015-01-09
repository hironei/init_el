;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-

                                        ;
;; 環境変数 LANG にja_JP.UTF-8 が設定されている必要がある
;;(setenv "LANG" "ja_JP.UTF-8")

;; 言語は日本語
(set-language-environment "Japanese")


(when nt-p
  ;; IMEのON/OFFでカーソルの色を変える
  (add-hook 'w32-ime-on-hook
            (function (lambda () (set-cursor-color "cyan"))))
  (add-hook 'w32-ime-off-hook
            (function (lambda () (set-cursor-color "green"))))
  )

(provide '05_character)
