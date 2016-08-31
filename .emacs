; Unnecessary GUI
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode t)
(setq inhibit-startup-message t)

; Avoid using tabs
(setq indent-tabs-mode nil)

; But set their default size nevertheless
;(setq tab-width 4)

; Save mini-buffer history between sessions
(savehist-mode t)

; Highlight matching parenthesis
(show-paren-mode 1)

; Auto fill mode by default
(add-hook 'text-mode-hook 'turn-on-auto-fill)

; Nice font face
;; (set-default-font "Terminus-12")
;; (set-default-font "Fira Mono")
;; (set-default-font "PragmataPro:pixe")
(set-default-font "PragmataPro:pixelsize=13")
;; (set-default-font "Fira Mono:pixelsize=13:antialias=none")
;; (set-default-font "Dina-12")
 
; Theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (pocolors)))
 '(custom-safe-themes
   (quote
    ("6626b989746fdbcf1be62f31d7587169ddf270736665835fc63a59bd25974b18" "de026031024f28513c2c5248fcc7cdc4aead5c378738ae173ce7e04a71fe9f16" default)))
 '(irony-cmake-executable "/0/gentoo/usr/bin/cmake")
 '(package-selected-packages
   (quote
    (vala-mode toml-mode sbt-mode rust-mode rainbow-mode qml-mode notmuch markdown-mode lua-mode jinja2-mode haskell-mode git-timemachine evil ess coffee-mode cmake-mode))))
 
;; '(ido-enable-flex-matching t))

; Add the MELPA package repository
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives
    '("melpa" . "http://melpa.milkbox.net/packages/") t))

;(require 'evil)
;(evil-mode 1)

;; On-the-fly reindentation
;(electric-indent-mode t)

;(require 'ido)
;(ido-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)

;; Preferred indentation
;(defun xico-cpp-setup ()
  ; Avoid indenting after namespace
;  (c-set-offset 'innamespace [0]))
					;(add-hook 'c++-mode-hook 'xico-cpp-setup)

;; Add C++11 keywords
(font-lock-add-keywords 'c++-mode
			'(("constexpr" . font-lock-keyword-face)))

;; Org-mode
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(setq org-log-done 'time)
(setq org-agenda-files (list "~/org/journal.org"))
;;(add-to-list 'org-modules 'org-habits)

;(require 'ess-site)
;(setq-default ess-dialect "R")

;; Airbus coding style
(defun bj-cc-setup ()
  (c-set-offset 'innamespace [0]))
(add-hook 'c++-mode-hook 'bj-cc-setup)

;; C++ headers are named *.h
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Highlight TODOs and co
(add-hook 'prog-mode-hook
          (lambda ()
	    (font-lock-add-keywords nil
				    '(("\\<\\(TODO\\):" 1
				       font-lock-warning-face t)))))

;;(push "/0/local/rtags/share/emacs/site-lisp/rtags" load-path)
;;(require 'rtags)

;; php-mode
(add-to-list 'load-path "~/.emacs.d/packages/php-mode-1.17.0")
(require 'php-mode)

;; magit
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/dash")
;;(require 'dash)
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/with-editor")
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/magit/lisp")
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)

;; Manually installed packages
(let ((default-directory (concat user-emacs-directory
				 (convert-standard-filename "lisp/"))))
  (normal-top-level-add-subdirs-to-load-path))

;; irony
(load "irony")
(load "irony-cdb")
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;(with-eval-after-load 'info
 ;;                     (info-initialize)
  ;;                    (add-to-list 'Info-directory-list
   ;;                                "~/.emacs.d/site-lisp/magit/Documentation/"))

(add-hook 'c++-mode-hook (lambda ()
			   (local-set-key (kbd "RET") 'newline-and-indent)))

;; rtags
(add-to-list 'load-path "/0/local/share/emacs/site-lisp/rtags")
(setq rtags-path "/0/local/bin")
(require 'rtags)
(require 'company)
(require 'company-rtags)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
(setq rtags-completions-enabled t)
(eval-after-load 'company
  '(add-to-list
    'company-backends 'company-rtags))
(setq rtags-autostart-diagnostics t)
(rtags-enable-standard-keybindings)

;; compilation shortcut
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))
