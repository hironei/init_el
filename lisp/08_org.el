;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org
  :bind (
         ("C-c l" . org-store-link)
         ("C-c c" . org-capture) 
         ("C-c a" . org-agenda)  
         ("C-c b" . org-iswitchb)
         )
  :mode ("\\.org$" . org-mode)
  :commands (org-mode org-store-link org-agenda org-iswitchb org-remember)
  :init
  (progn
    (setq org-directory "c:/work/4_memo/")
    (setq org-default-notes-file (concat org-directory "note.org"))
    (setq org-agenda-files (list org-directory))
    (setq org-export-copy-to-kill-ring nil)
    (setq org-html-validation-link nil)
    ;; 確認メッセージを出さない
    (setq org-confirm-babel-evaluate nil)
    ;; Color Highlight
    (setq org-src-fontify-natively t)

    (setq org-capture-templates
          '(("t" "Task" entry (file+headline nil "Inbox")
             "** TODO %?\n %T\n %a\n %i\n")
            ("b" "Bug" entry (file+headline nil "Inbox")
             "** TODO %?   :bug:\n  %T\n %a\n %i\n")
            ("m" "Meeting" entry (file+headline nil "Meeting")
             "** %?\n %U\n %a\n %i\n")
            ("i" "Idea" entry (file+headline nil "Idea")
             "** %?\n %U\n %i\n %a\n %i\n")
            ))
    )
  :config
  (require 'ox-textile)

  (require 'org-install)
  ;; ditaa
  (setq org-ditaa-jar-path
        "C:/home/local/lib/ditaa0_9.jar")
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((ditaa . t))) ; this line activates ditaa

  ;; org-plantuml-jar-path は plantuml.jar へのパス
  (setq org-plantuml-jar-path (expand-file-name "~/bin/plantuml.jar"))
  (org-babel-do-load-languages
   'org-babel-load-languages
   (add-to-list 'org-babel-load-languages '(plantuml . t)))

  ;; TODO状態
  (setq org-todo-keywords
        '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))
  ;; DONEの時刻を記録
  (setq org-log-done 'date)
  ;; org-redmine
  (require 'org-redmine)
  (setq org-redmine-uri "XXX")
  (setq org-redmine-auth-api-key "XXX")
  (setq org-redmine-template-header "TODO [#%i%] %s%")
  (setq org-redmine-template-property
        '(
          ;; ("project_name" . "%p_n%")
          ("tracker " . "%t_n%")
          ("assigned_to" . "%as_n%")
          ("version" . "%v_n%")
          ))
  
  )             

(provide '08_org)
