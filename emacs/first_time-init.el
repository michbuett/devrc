;; For the first run: rename this file to "init.el" and start emacs.
;; This file replaces itself with the actual configuration.

(require 'org)
(find-file (concat user-emacs-directory "init.org"))
(org-babel-tangle)
(load-file (concat user-emacs-directory "init.el"))
(byte-compile-file (concat user-emacs-directory "init.el"))
