;; instructions https://github.com/ftravers/emacs-ground-up
;;
;;; Code:
(set-face-attribute 'default nil :height 140 :family "Menlo")

;; interesting page:
;; https://github.com/emacs-evil/evil-collection/issues/116
;; ============= package archives ========
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;; ============== use package =============
(package-initialize)
(when (not package-archive-contents) (package-refresh-contents))
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))
(require 'use-package)
(setq use-package-always-ensure t)    ;; download packages if not already downloaded
(setq evil-want-keybinding nil)
(add-to-list 'exec-path "/usr/local/bin")

;; ============== favorite packages ==================
(use-package flycheck-clj-kondo)
(use-package clojure-mode
  :ensure t
  :mode ("\\.clj\\'")
  :config
  (require 'flycheck-clj-kondo))
(use-package clj-refactor)
(use-package evil)                      ; vi like key bindings
(use-package projectile)                ; navigate git projects
(use-package diminish)                  ; reduce mode-line clutter
(use-package delight)                   ; change how modes appear in mode-line
(use-package which-key                  ; show which keys you can press next
  :diminish which-key-mode)
(use-package lispy)                     ; structural lisp editing
(use-package evil-lispy)                ; vi bindings for lispy
(use-package helm-projectile            ; auto-complete commands
  :diminish helm-mode)
(use-package helm-ag)
(use-package winum)                     ; switch between buffers using numbers
(use-package magit)                     ; git integration
(use-package evil-magit)                ; vi bindings for magit
(use-package highlight-parentheses)     ; rainbow parens
(use-package company)                   ; completion
(use-package buffer-move)               ; move buffers
(use-package el-get)                    ; package management
(use-package cider)                     ; clojure debugger
(use-package general                    ; key binding framework
  :config (general-evil-setup t))
(use-package goto-chg)                  ; goto last edit
(use-package repeat)                    ; make repeatable commands
(use-package hydra)                     ; hydra menus
(use-package clomacs)                   ; call clojure from elisp and vice-versa
(require 'clomacs)
(use-package ivy)
(require 'thingatpt)
(use-package auto-complete)
(use-package evil-surround :ensure t :config (global-evil-surround-mode 1))
(use-package command-log-mode)
(use-package htmlize)
(use-package markdown-mode)
(use-package elisp-refs)
(use-package org-preview-html)
(use-package flymd)                     ; live preview org-mode -> markdown
(use-package neotree)
;; (use-package dired+)
;; let normal dired be used instead of helm-dired

(use-package ivy)
(use-package counsel)
(use-package counsel-projectile)
(use-package flycheck-joker)
(use-package edit-indirect)
(use-package dash)
(use-package eval-sexp-fu)
(use-package evil-escape)

;; ========== function defs ==========
(add-to-list 'load-path "~/.fenton-emacs.d/lisp/")
(add-to-list 'load-path "~/.fenton-emacs.d/src/")
(load "my-functions.el")
(load "key-defs-hydras.el")
(load "utilities.el")
(load "sunrise-commander.el")
;;(load "ft_git.el")
;; (load "jump_unit.el")
;;(add-to-list 'load-path "~/.fenton-emacs.d/test/")

;; clj kondo
(dolist (checker '(clj-kondo-clj clj-kondo-cljs clj-kondo-cljc clj-kondo-edn))
  (setq flycheck-checkers (cons checker (delq checker flycheck-checkers))))
(dolist (checkers '((clj-kondo-clj . clojure-joker)
                    (clj-kondo-cljs . clojurescript-joker)
                    (clj-kondo-cljc . clojure-joker)
                    (clj-kondo-edn . edn-joker)))
  (flycheck-add-next-checker (car checkers) (cons 'error (cdr checkers))))

;; use a bunch of minor modes
;; (elpy-enable)

;; Python
;; Use IPython for REPL
;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt"
;;       python-shell-prompt-detect-failure-warning nil)
;; (add-to-list 'python-shell-completion-native-disabled-interpreters
;;              "jupyter")
;; Enable Flycheck
;; (when (require 'flycheck nil t)
;;   (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;   (add-hook 'elpy-mode-hook 'flycheck-mode))

(setq ediff-autostore-merges t)
;;(global-prettify-symbols-mode 1) ;; display “lambda” as “λ”

;; Evil mode settings

;; Evil mode
(evil-mode 1)
(setq-default evil-normal-state-cursor 'box)
(setq-default evil-insert-state-cursor 'bar)

;; Evil-Escape allows you to use chorded escape keys like "fd"
(evil-escape-mode)
(setq-default evil-escape-key-sequence "fd")
(setq-default evil-escape-unordered-key-sequence t)

(which-key-mode)
(winum-mode)
(global-company-mode)
;; (helm-mode 1)
(projectile-mode)
;; (helm-projectile-on)
(mouse-wheel-mode t)                    ; mouse scrolling
(line-number-mode 1)                    ; Show line-number and column-number in the mode line
(column-number-mode 1)                  ; Show line-number and column-number in the mode line
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(highlight-parentheses-mode 1)
(save-place-mode)
(desktop-save-mode 1)
(show-paren-mode 1)
(global-prettify-symbols-mode 1)
(ivy-mode 1)
(counsel-projectile-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

;; Themes
;; (load-theme 'wombat t)
;; (load-theme 'spacegray t)
;; (load-theme 'color-theme-sanityinc-tomorrow-day t)
(load-theme 'leuven t)

;; (add-to-list 'helm-completing-read-handlers-alist '(dired . nil))
(setq-default truncate-lines t          ; dont wrap long lines
              indent-tabs-mode nil)   ; always replace tabs with spaces

(setq inhibit-startup-message t
      blink-cursor-mode 0
      org-clock-persist 'history
      lispy-close-quotes-at-end-p t
      dired-dwim-target t
      initial-scratch-message nil ; Don't insert instructions in the *scratch* buffer
      select-enable-clipboard t ; set cut/copy to go to system clipboard
      backup-directory-alist '(("" . "~/.fenton-emacs.d/backup")) ; put all backups here
      scroll-step 1 ; Scroll one line (not half a page) when moving past the bottom of the window
      help-window-select t
      projectile-completion-system 'avy
      ;; projectile-completion-system 'helm
      ;; projectile-switch-project-action 'helm-projectile
      cider-font-lock-dynamically '(macro core function var)
      ;; cider-pprint-fn "clojure.pprint/pprint"
      cider-repl-use-pretty-printing t
      cider-repl-pop-to-buffer-on-connect nil
      cider-eldoc-display-context-dependent-info t
      cider-overlays-use-font-lock t
      ;; cider-default-cljs-repl 'figwheel-main
      eldoc-echo-area-use-multiline-p 'truncate-sym-name-if-fit
      cider-eldoc-display-context-dependent-info t
      cider-overlays-use-font-lock t
      cider-prompt-for-symbol nil
      cider-auto-select-test-report-buffer t
      cider-auto-test-mode 1
      cider-test-show-report-on-success nil
      cider-default-cljs-repl "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))"
      show-paren-delay 0
      hl-paren-colors '("red" "green1" "orange1" "cyan1" "yellow1" "slateblue1" "magenta1" "purple")
      hl-paren-background-colors '("gray14" "gray14" "gray14" "gray14" "gray14" "gray14" "gray14" "gray14")
      desktop-dirname (expand-file-name "~/.fenton-emacs.d/")
      desktop-auto-save-timeout 30
      desktop-base-file-name "emacs.desktop"
      desktop-base-lock-name "lock"
      desktop-path (list desktop-dirname)
      desktop-files-not-to-save "^$"
      flymd-browser-open-function 'my-flymd-browser-function
      frame-title-format '((:eval (if (buffer-file-name) (abbreviate-file-name (buffer-file-name)) "%b"))))
(org-clock-persistence-insinuate)
(setq helm-ag-base-command "rg --vimgrep --no-heading")
(fset 'yes-or-no-p 'y-or-n-p)           ; When emacs asks for "yes" or "no", let "y" or "n" sufficide
(add-to-list 'auto-mode-alist '("\\.cljs\\'" . clojurescript-mode))
(set-face-background 'show-paren-match "#640000")
(delight '(
           ;; (helm-mode)
           (emacs-lisp-mode)))
(eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
(mapcar 'diminish '(lispy-mode
                    ;; helm-mode
                    auto-revert-mode projectile-mode))
(define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)

;; ============= HOOKS ==============================
(add-hook 'prog-mode-hook
          (lambda ()
            (highlight-parentheses-mode 1)
            (flycheck-mode)
            (hs-minor-mode)
            (flycheck-mode)
            (hs-hide-all)))
(add-hook 'text-mode-hook
          (lambda ()
            (auto-fill-mode 1)))
(add-hook 'cider-repl-mode-hook
          (lambda ()
            (highlight-parentheses-mode 1)
            (company-mode)))
(add-hook 'org-mode-hook
          (lambda ()
            (auto-fill-mode 1)))
(add-hook 'markdown-mode-hook
          (lambda ()
            (auto-fill-mode 1)))
(add-hook 'ielm-mode-hook 'ielm-auto-complete)
(add-hook 'cider-mode-hook
          (lambda ()
            (highlight-parentheses-mode 1)
            (clj-refactor-mode 1)
            (yas-minor-mode 1)
            (company-mode)
            (cider-company-enable-fuzzy-completion)
            (eldoc-mode)))
(add-hook 'elpy-mode-hook
          (lambda ()
            (eval-sexp-fu-flash-mode)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#ffffff" "#bf616a" "#B4EB89" "#ebcb8b" "#89AAEB" "#C189EB" "#89EBCA" "#232830"))
 '(custom-enabled-themes (quote (sanityinc-tomorrow-day)))
 '(custom-safe-themes
   (quote
    ("bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" default)))
 '(fci-rule-color "#343d46")
 '(package-selected-packages
   (quote
    (color-theme-sanityinc-tomorrow spacegray-theme evil-escape ob-clojure eval-sexp-fu elpy js2-mode ein edit-indirect flycheck-clj-kondo counsel-projectile elisp-refs neotree neo-tree org-preview-html evil-collection flymd markdown-mode magit-gh-pulls treemacs-projectile treemacs-evil htmlize command-log-mode clj-refactor evil-surround auto-complete cider-eldoc sr-speedbar cider winum wk use-package magit lispy highlight-parentheses helm-projectile helm-ag evil el-get diminish delight company clojure-mode buffer-move)))
 '(safe-local-variable-values
   (quote
    ((elisp-lint-indent-specs
      (if-let* . 2)
      (when-let* . 1)
      (let* . defun)
      (nrepl-dbind-response . 2)
      (cider-save-marker . 1)
      (cider-propertize-region . 1)
      (cider-map-repls . 1)
      (cider--jack-in . 1)
      (cider--make-result-overlay . 1)
      (insert-label . defun)
      (insert-align-label . defun)
      (insert-rect . defun)
      (cl-defun . 2)
      (with-parsed-tramp-file-name . 2)
      (thread-first . 1)
      (thread-last . 1))
     (checkdoc-package-keywords-flag)
     (source-dir . "aoc2018_14")
     (source-dir . "aoc2018_13")
     (source-dir . aoc2018_13))))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#bf616a")
     (40 . "#DCA432")
     (60 . "#ebcb8b")
     (80 . "#B4EB89")
     (100 . "#89EBCA")
     (120 . "#89AAEB")
     (140 . "#C189EB")
     (160 . "#bf616a")
     (180 . "#DCA432")
     (200 . "#ebcb8b")
     (220 . "#B4EB89")
     (240 . "#89EBCA")
     (260 . "#89AAEB")
     (280 . "#C189EB")
     (300 . "#bf616a")
     (320 . "#DCA432")
     (340 . "#ebcb8b")
     (360 . "#B4EB89"))))
 '(vc-annotate-very-old-color nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(sr-active-path-face ((t (:background "black" :foreground "yellow" :weight bold :height 120))))
 '(sr-highlight-path-face ((t (:background "black" :foreground "#ace6ac" :weight bold :height 120))))
 '(sr-passive-path-face ((t (:background "black" :foreground "lightgray" :weight bold :height 120)))))

(add-to-list 'evil-emacs-state-modes 'dired-mode)

(provide 'init)
