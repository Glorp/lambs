;;; -*- lexical-binding: t -*-
(require 'cl-lib)
(require 'cl)
(setq lambda-homedir (file-name-as-directory (getenv "HOME")))
(load (format "%slambs/init_lambs.el" lambda-homedir))
(load (format "%slambs/repl.el" lambda-homedir))

(set-language-environment "UTF-8")
(setq-default indent-tabs-mode nil)
(setq visible-bell 't)

(global-set-key [C-tab] 'dabbrev-expand)
(global-set-key (kbd "C-l") (lambda () (interactive) (insert "\u03bb")))
(global-set-key (kbd "C-d") (lambda () (interactive) (insert "\u225C")))

(global-set-key (kbd "C-<") 'match-paren)

(defun match-paren ()
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive)
  (cond ((looking-at "\\s\(") (forward-list 1))
	((looking-back "\\s\)") (backward-list 1))
	(t nil)))

(global-set-key (kbd "C-g")
                (lambda (n)
                  (interactive "nGoto line: ")
                  (goto-line n)
                  (recenter)))
(global-set-key (kbd "C-z") 'undo)

(setq inhibit-splash-screen t)

(load-theme 'dichromacy)
(custom-set-variables )
(custom-set-faces
 '(default ((t (:family "DejaVu Sans Mono"
                :foundry "outline"
                :slant normal
                :weight normal
                :height 203
                :width normal)))))

(set-default 'cursor-type 'bar)
(if (window-system) (set-frame-size (selected-frame) 80 30))

(column-number-mode)
(setq mouse-wheel-scroll-amount '(2 ((shift) . 4)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)
(setq scroll-conservatively 10000)

(add-hook 'org-mode-hook (lambda () (org-indent-mode t)) t)

(cd (format "%slambs" lambda-homedir))
(tool-bar-mode -1)

(global-linum-mode 1)

(setq show-paren-delay 0)
(show-paren-mode 1)

(switch-to-buffer (get-buffer-create "lambda"))
(global-linum-mode 1)

(insert (get-string-from-file (format "%slambs/lambda-init.txt" lambda-homedir)))
(goto-char 1)
