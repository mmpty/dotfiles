;; .emacs --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; require myPackages

(defvar myPackages
  '(all-the-icons
    better-defaults
    dracula-theme
    iedit
    elpy
    flycheck
    neotree
    py-autopep8
    rainbow-delimiters
    slime
    auto-complete
    yasnippet))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'dracula t) ;; load dracula theme
(global-linum-mode t) ;; enable line numbers globally
(show-paren-mode 1)   ;; enable paren-mode
(define-key global-map (kbd "C-c ;") 'iedit-mode) ;; iedit keybind
(require 'auto-complete)
(require 'auto-complete-config)  ;; start auto-complete with emacs
(ac-config-default) ;; auto complete por padrao
(require 'yasnippet) ;; start yasnippet with emacs
(yas-global-mode 1)



;;  RAINBOW-DELIM
;; ----------------------------------------------

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  
;; R SHXT
;; --------------------------------------
(require 'ess-site)
(require 'ess-r-mode)

(defun myindent-ess-hook ()
  (setq ess-indent-level 4))
(add-hook 'ess-mode-hook 'myindent-ess-hook)

;; NEOTREE
;; -------------------------------------

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; ------------ SLIME/QUICKLISP -------------------- ;;

(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")

;; .emacs ends here
