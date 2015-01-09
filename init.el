;;; -*- mode: emacs-lisp; coding: sjis-dos; indent-tabs-mode: nil -*-
(load-file "c:/home/ya-hirose/.emacs.d/elpa/initchart-0.1.1/initchart.el")
(initchart-record-execution-time-of load file)
(initchart-record-execution-time-of require feature)


(add-to-list 'load-path "~/.emacs.d/lisp/")
(require '01_load)
(require '02_enviroment)
(require '03_keybind)
(require '04_face)
(require '05_character)
(require '06_tool)
(require '07_helm)
(require '08_org)
(require '09_lang)
(require '99_other)


;;(require 'esup)
