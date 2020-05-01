(defhydra hydra-markdown-comma () ""
  ("h" flymd-flyit "html preview" :exit t)
  ("q" nil "quit" :exit t))
(defhydra hydra-cider-test-report-comma ()
  " ^TEST^ ^TEST MOVEMENT^ _r_ re-run test _k_ prev _d_ goto definition _j_ next
"
  ("r" cider-test-run-test nil)
  ("d" cider-test-jump nil :exit t)

  ("k" cider-test-previous-result nil)
  ("j" cider-test-next-result nil)

  ("q" nil "quit" :exit t))
(defhydra hydra-lisp-spc-s ()
  "
^Symbol^    ^Manual^   
_y_ search  _s_ search  
_k_ up      _p_ replace   
_j_ down      
_r_ replace
"
  ("y" isearch-forward-symbol-at-point nil)
  ("k" isearch-repeat-backward nil)
  ("j" isearch-repeat-forward nil)
  ("r" query-replace-symbol-at-point nil :exit t)

  ("s" isearch-forward nil :exit t)
  ("p" query-replace nil :exit t)

  ("q" isearch-exit "Quit" :exit t))
(defhydra hydra-spc () ""
  ("1" winum-select-window-1 nil :exit t)
  ("2" winum-select-window-2 nil :exit t)
  ("3" winum-select-window-3 nil :exit t)
  ("4" winum-select-window-4 nil :exit t)
  ("5" winum-select-window-5 nil :exit t)
  ("SPC" helm-M-x "run command" :exit t)
  ("w" hydra-spc-w/body "windows" :exit t)
  ("q" nil "quit" :exit t :color pink))
(defhydra hydra-spc-m () ""
  ("r" kmacro-start-macro "record macro" :exit t)
  ("s" kmacro-end-macro "stop record macro" :exit t)
  ("p" kmacro-end-and-call-macro "rePlay macro")
  ("q" nil "quit" :exit t))
(defhydra hydra-sunrise-spc ()
  ""
  ("1" winum-select-window-1 nil :exit t)
  ("2" winum-select-window-2 nil :exit t)
  ("3" winum-select-window-3 nil :exit t)
  ("4" winum-select-window-4 nil :exit t)
  ("5" winum-select-window-5 nil :exit t)
  ("SPC" helm-M-x "run command" :exit t)

  ("m" dired-create-directory "create directory" :exit t)
  ("o" dired-do-chown "chown" :exit t)
  ("M" dired-do-chmod "chmod" :exit t)
  ("g" revert-buffer "refresh" :exit t)

  ("q" nil "quit" :exit t :color pink)
  )
(defhydra hydra-spc-e () ""
  ("a" (lambda () (interactive) (find-file "/home/fenton/.aliases_common")) "aliases" :exit t)
  ("e" (lambda () (interactive) (find-file "/home/fenton/.zshrc")) "environment" :exit t)
  ("z" (lambda () (interactive) (find-file "/home/fenton/.zshrc-functions.sh")) "zsh functions" :exit t)
  ("i" (lambda () (interactive) (find-file (concat user-emacs-directory "/init.el"))) "init" :exit t)
  ("f" (lambda () (interactive) (find-file (concat user-emacs-directory "/lisp/my-functions.el"))) "functions" :exit t)
  ("h" (lambda () (interactive) (find-file (concat user-emacs-directory "/lisp/key-defs-hydras.el"))) "hydras" :exit t))
(defhydra hydra-spc-f ()
  ""
  ("d" dired "dired" :exit t)
  ;; ("f" helm-find-files nil :exit t)
  ("f" counsel-find-file "find" :exit t)
  ("s" write-file "save as" :exit t)

  ("X" er-delete-file-and-buffer "delete" :exit t)
  ("n" rename-file-and-buffer "rename" :exit t)
  ("r" counsel-recentf "recent" :exit t)
  ;; ("F" my-dired-find-file nil :exit t)

  ("q" nil "quit" :exit t :color pink))
(defhydra hydra-spc-b ()
  "
^Goto   ^  ^Save   ^  ^Misc   ^     ^FONT SIZE^
^-------^  ^------^   ^---------^   ^----------^
_k_ prev   _s_ this   _d_ kill      _U_ increase
_j_ next   _a_ all    _b_ list      _u_ decrease
"
  ("k" fenton/previous-code-buffer nil)
  ("j" fenton/next-code-buffer nil)

  ("s" save-buffer nil)
  ("a" (lambda () (interactive) (save-some-buffers t)) nil :exit t)
  ("d" (lambda () (interactive) (kill-this-buffer) (fenton/next-code-buffer)) nil)
  ("i" ibuffer "IBuffer" :exit t)
  ("b" helm-mini "Helm Mini" :exit t)

  ("C-k" ft/check-uncommited-then-quit "quit Emacs" :exit t)

  ("U" text-scale-increase nil)
  ("u" text-scale-decrease nil)

  ("N" display-line-numbers-mode "toggle Line Numbers")
  ("m" hydra-spc-w-m/body ">Move<" :exit t)

  ("q" nil "quit" :exit t :color pink))
(defhydra hydra-spc-w ()
  "
_l_ widen   _s_ swap   _d_ delete   _v_ split vert
_h_ narrow  _r_ rotate _m_ maximize _-_ split horiz
_i_ taller  _o_ other  _=_ balance 
"
  ("l" enlarge-window-horizontally nil)
  ("h" shrink-window-horizontally nil)
  ("i" enlarge-window nil)

  ("d" delete-window-balance nil :exit t)
  ("m" delete-other-windows nil :exit t)
  ("v" split-window-vertical-balance nil :exit t)
  ("-" split-window-below-balance nil :exit t)
  ("=" balance-windows nil :exit t)

  ("s" swap-windows nil)
  ("r" fenton/rotate-window-split nil :exit t)
  ("o" other-window nil)

  ("q" nil "quit" :exit t :color pink))
(defhydra hydra-spc-w-m ()
  "
^^      _k_ up
_h_ left ^^     _l_ right
^^      _j_ down
"
  ("h" buf-move-left nil)
  ("j" buf-move-down nil)
  ("k" buf-move-up nil)
  ("l" buf-move-right nil)
  ("q" nil "quit" :exit t :color pink))
(defhydra hydra-org-spc-o ()
  ""
  ("s" (lambda () (interactive) (org-shifttab)) "cycle all")
  ("h" (lambda () (interactive) (org-shifttab)) "cycle all")
  ("t" (lambda () (interactive) (org-cycle)) "toggle this")
  ("q" nil "quit" :exit t :color pink))
(defhydra hydra-repl-g ()
  "
 ^Workspace^        ^Scroll Page^
 _1_                _j_ down
 _2_                _k_ up
 _3_
 _s_ save workspc
"
  ("1" (lambda () (interactive (jump-to-register 49))) nil :exit t)
  ("2" (lambda () (interactive (jump-to-register 50))) nil :exit t)
  ("3" (lambda () (interactive (jump-to-register 51))) nil :exit t)
  ("s" window-configuration-to-register nil :exit t)

  ("j" evil-scroll-page-down)
  ("k" evil-scroll-page-up)
  
  ("g" evil-goto-first-line "first line" :exit t)
  ("r" cider-switch-to-last-clojure-buffer "last cloj buf" :exit t)
  ("q" nil "quit" :exit t))
(defhydra hydra-cloj-g ()
  "
^Clojure^         ^Scroll Page^ 
_r_ REPL          _j_ down      
_t_ test          _k_ up        
_p_ test report                 
_c_ cloj         
"
  ("r" cider-switch-to-repl-buffer nil :exit t)
  ("t" ft/jump-to-src-or-test-file nil :exit t)
  ;; ("t" toggle-goto-test-impl nil :exit t)
  ("p" (switch-to-buffer-other-window "*cider-test-report*") nil :exit t)
  ("c" toggle-goto-test-impl nil :exit t)

  ("f" lispy-fill "Fill Paragraph" :exit t)
  ("d" cider-doc "cider docs" :exit t)

  ("k" evil-scroll-page-up)
  ("j" evil-scroll-page-down)
  
  ("g" evil-goto-first-line "first line" :exit t)
  ("l" avy-goto-line "goto line" :exit t)
  
  ("e" hydra-g-e/body ">Edit Pos<" :exit t)
  ("n" hydra-g-n/body ">Narrow/Widen" :exit t)

  ("s" sunrise "sunrise" :exit t)

  ("q" nil "quit" :exit t)) 
(defhydra hydra-g ()
  "
^Workspace^      ^Scroll Page^  ^Misc^
_1_              _j_ down       _f_ fill paragraph
_2_              _k_ up         _F_ fill para next 
_3_              ^^             _u_ unfill paragraph
_w_ save workspc
"
  ("w" window-configuration-to-register nil :exit t)
  ("1" (lambda () (interactive (jump-to-register 49))) nil :exit t)
  ("2" (lambda () (interactive (jump-to-register 50))) nil :exit t)
  ("3" (lambda () (interactive (jump-to-register 51))) nil :exit t)

  ("k" evil-scroll-page-up nil)
  ("j" evil-scroll-page-down nil)

  ("f" lispy-fill nil :exit t)
  ("F" (lambda () (interactive) (lispy-fill) (forward-paragraph)) nil)
  ("u" unfill-paragraph-forward-p nil)

  ("m" hydra-g-m/body ">My Files<" :exit t)
  ("g" evil-goto-first-line "first line" :exit t)
  ("l" avy-goto-line "goto line" :exit t)
  ("t" ft/jump-to-src-or-test-file nil :exit t)
  ("e" hydra-g-e/body ">Edit Post<" :exit t)

  ("s" ft/fix-bank-statement "fix bank statement" :exit t)

  ("n" hydra-g-n/body ">Narrow/Widen" :exit t)

  ("q" nil "quit" :exit t))
(defhydra hydra-g-n () ""
  ("n" narrow-to-defun "narrow" :exit t)
  ("w" widen "widen" :exit t))
(defhydra hydra-g-e ()
  "
^Buffer^   ^Edit Pos^ ^Page^   
_p_ prev   _k_ prev   _u_ up   
_n_ next   _j_ next   _d_ down 
_x_ close  
"
  ("p" previous-buffer nil)
  ("n" next-buffer nil)
  ("x" (lambda () (interactive) (kill-this-buffer) (next-buffer)) nil)

  ("k" goto-last-change nil)
  ("j" goto-last-change-reverse nil)

  ("u" evil-scroll-page-up nil)
  ("d" evil-scroll-page-down nil)

  ("q" nil "quit" :exit t))
(defhydra hydra-g-m () ""
  ("f" (lambda () (interactive) (find-file-other-window (concat user-emacs-directory "/lisp/my-functions.el"))) "funcs" :exit t)
  ("h" (lambda () (interactive) (find-file-other-window (concat user-emacs-directory "/lisp/key-defs-hydras.el"))) "hydras" :exit t)
  ("i" (lambda () (interactive) (find-file-other-window (concat user-emacs-directory "/init.el"))) "init" :exit t)
  ("t" (lambda () (interactive) (find-file-other-window (concat user-emacs-directory "/lisp/my-functions-tests.el"))) "tests" :exit t))
(defhydra hydra-elisp-comma ()
  "
^SEXP MOVEMENT^    ^^                    ^^
_[_ to top level   ^^                    _o_ insert space around   
_j_ next           _e_ eval sexp/buffer  _t_ run regression unit tests
_k_ prev           _._ find defn         _n_ narrow to defun
_]_ to open paren  _,_ pop back          _w_ widen to file
"
  ("[" (lambda () (interactive) (goto-top-level-sexp) (evil-lispy-state)) nil :exit t)
  ("j" forward-parent-sexp nil)
  ("k" backward-parent-sexp nil)
  ("]" first-open-paren nil :exit t)
  
  ("fd" edebug-eval-top-level-form nil :exit t)
  ("e" eval-sexp-or-buffer nil :exit t)
  ("." lispy-goto-symbol "find definition" :exit t)
  ("," xref-pop-marker-stack "pop back" :exit t)

  ("o" insert-space-around-sexp nil)
  ("t" (lambda () (interactive) (ert t)) nil :exit t)
  ("n" (call-interactively #'narrow-to-defun) nil :exit t)
  ("w" (call-interactively #'widen) nil :exit t)

  ;; ("SPC" hydra-edebug-comma-spc/body :exit t)
  ("p" ft/eval-last-sexp-print-in-comment "print last sexp" :exit t)
  ("h" hydra-elisp-comma-h/body "apropos" :exit t)
  ("l" eval-buffer "load buffer" :exit t)

  ("dd" ft/elisp-index-symbol-at-point "elisp index symb at pt" :exit t)
  ("da" helm-apropos "search functions, commands, variables" :exit t)
  ("di" info-apropos "info apropos" :exit t)

  ("v" lispy-debug-step-in "globalize local Vars" :exit t)
  
  ("q" nil "quit" :exit t))
(defhydra hydra-elisp-comma-h () ""
  ("a" helm-apropos "search functions, commands, variables" :exit t)
  ("e" ft/elisp-index-symbol-at-point "elisp index symb at pt" :exit t)
  ("i" info-apropos "info apropos" :exit t))
(defhydra hydra-org-comma-t ()
  ""
  ("t" org-todo "cycle todo|done")
  ("i" org-clock-in "clock in")
  ("o" org-clock-out "clock out")
  ("d" org-clock-display "display")
  ("c" org-clock-cancel "cancel")

  ("q" nil "quit" :exit t))
(defhydra hydra-org-comma ()
  "
_j_ next                 _w_ move tree up        _c_ cut              _u_ page up
_k_ prev                 _s_ move tree down      _p_ paste            _d_ page down
_h_ prev heading         _C-h_ promote subtree   _o_ cycle fOld all   _SPC_ toggle todo
_l_ next visib heading   _C-l_ demote subtree    _x_ cycle fold this 
"
  ("j" org-forward-element nil)
  ("k" org-backward-element nil)
  ("l" org-next-visible-heading nil)
  ("h" org-previous-visible-heading nil)

  ("w" org-move-subtree-up nil)
  ("s" org-move-subtree-down nil)
  ("C-h" org-promote-subtree nil)
  ("C-l" org-demote-subtree nil)

  ("c" org-cut-subtree nil)
  ("p" org-paste-subtree nil)
  ("o" org-shifttab nil)
  ("x" org-cycle nil)

  ("d" evil-scroll-page-down nil)
  ("u" evil-scroll-page-up nil)
  ("SPC" org-shiftright nil)

  ("t" hydra-org-comma-t/body "todos" :exit t)
  ("e" org-preview-html-mode "preview" :exit t)
  ("q" nil "quit" :exit t))
(defhydra hydra-repl-comma () ""
  ("k" cider-repl-backward-input "Previous Command")
  ("j" cider-repl-forward-input "Next Command")
  ("r" hydra-cloj-comma-r/body "+REPL+" :exit t)
  ("q" nil "quit" :exit t)
  ("ESC" nil nil :exit t))
;; (defhydra hydra-edebug-comma () ""
;;   ("n" edebug-step-mode "next" :exit nil)
;;   ("i" edebug-step-in "step in" :exit nil)
;;   ("o" edebug-step-out "step out" :exit nil)
;;   ("q" top-level "quit" :exit t))
(defhydra hydra-cloj-comma ()
  "
^SEXP MOVEMENT^    ^EVAL^            ^CIDER^                ^SEXP FORMAT^      ^EVAL&PRINT^
_[_ to top level   _l_ load buffer   _'_ CLJ  JackIn        _o_ space around   _p_ eval&print
_j_ next           _e_ top lvl sexp  _\"_ CLJS JackIn        _c_ clj refactor
_k_ next           ^^                _._ find defn          _u_ quote prev
_]_ to open paren  _x_ fn ref        _,_ pop back      
"
  ("[" (lambda () (interactive) (goto-top-level-sexp) (evil-lispy-state))  nil)
  ("j" forward-parent-sexp nil)
  ("k" backward-parent-sexp nil)
  ("]" first-open-paren nil :exit t)

  ("l" load-buffer-set-ns nil :exit t)  
  ("e" cider-eval-defun-at-point nil :exit t)
  
  ("x" (lambda () (interactive) (cider-xref-fn-refs)) nil :exit t)

  ("'" cider-jack-in nil :exit t)
  ("\"" cider-jack-in-cljs nil :exit t)
  ("." cider-find-var nil :exit t)
  ("," xref-pop-marker-stack nil :exit t)

  ("o" insert-space-around-sexp nil)
  ("c" hydra-cljr-help-menu/body nil :exit t)
  ("u" quote-prev-sexp nil :exit t)

  ("p" (call-interactively #'cider-pprint-eval-last-sexp-to-comment) :exit t)

  ("r" hydra-cloj-comma-r/body "+REPL+" :exit t)
  ("t" hydra-cloj-comma-t/body "+TESTS+" :exit t)
  ("g" hydra-cloj-comma-g/body "+GO+" :exit t)
  ("dd" cider-doc "symbol docs" :exit t)
  ("da" cider-apropos-documentation "apropos docs" :exit t)
  ("fd" cider-debug-defun-at-point "Debug defn" :exit t)
  ("ft" cider-toggle-trace-var "Trace defn" :exit t)
  ("fn" cider-toggle-trace-ns "Trace ns" :exit t)

  ("v" lispy-debug-step-in "globalize local Vars" :exit t)
  
  ("q" nil "quit" :exit t))
(defhydra hydra-cloj-comma-r ()
  "
^REPL^         ^SEXP^  
_g_ goto repl  _l_ insert last       
_n_ set ns     _p_ eval, print
_k_ kill       _r_ refresh
"
  ("g" cider-switch-to-repl-buffer nil :exit t)
  ("n" repl-reload-ns nil :exit t)
  ("k" cider-quit nil :exit t)
  ("r" cider-ns-refresh nil :exit t)
  ("c" cider-repl-clear-buffer "clear" :exit t)
  ;; ("r" ft/reload-reagent nil :exit t)
  ("l" cider-insert-last-sexp-in-repl nil :exit t)
  ("p" eval-last-sexp-pretty-print nil :exit t)

  ("q" nil "quit" :exit t))
(defhydra hydra-cloj-comma-g ()
  ""
  ("r" cider-switch-to-repl-buffer "Repl" :exit t)
  ("t" ft/toggle-goto-test-impl "Toggle src/test files" :exit t)
  ("p" (switch-to-buffer-other-window "*cider-test-report*") nil :exit t)
  ("d" hydra-cloj-comma-d/body "+DOCS+" :exit t)
  ("l" ft/pm-logs "Postmortem Logs" :exit t)
  ("q" nil "quit" :exit t))
(defhydra hydra-cloj-comma-t ()
  ""
  ("p" cider-test-run-project-tests "project tests" :exit t)
  ("t" ft/run-tests "ns tests" :exit t)
  ("q" nil "quit" :exit t))

(defhydra hydra-elpy-g () ""
  ("r" elpy-shell-switch-to-shell "go repl" :exit t)
  ("g" evil-goto-first-line "first line" :exit t)
  ("e" elpy-shell-send-region-or-buffer "execute" :exit t))

(setq none-any-all ; prefix-key: none, state: any, keymap: all
      '("(" (lispy-parens-from-normal :wk "enter lispy, insert parens")
        "q" (cider-popup-buffer-quit-function :wk "quit")
        "g" (hydra-g/body :wk "")
        "M-q" org-fill-paragraph
        "C-p" (helm-show-kill-ring :wk "show kill ring")
        "ESC" (keyboard-escape-quit :wk "quit")))
(setq none-shared-lisp
      '(";" lispy-comment
        "C-u" universal-argument
        "M-." lispy-goto-symbol
        "M-," pop-tag-mark
        "C-k" lispy-kill
        "C-y" evil-paste-before
        "C-n" evil-scroll-page-down
        ;; "C-p" evil-paste-before
        "q" self-insert-command))
(setq none-any-lisp none-shared-lisp)
(setq none-normal-lisp
      (append
       '("i" (i-lispy-normal :wk "insert -> lispy state")
         ;; "I" (I-lispy :wk "insert line -> lispy state")
         "o" (o-lispy :wk "open below -> lispy state")
         "O" (O-lispy :wk "open above -> lispy state")
         "a" (a-lispy :wk "append -> lispy state")
         "A" (A-lispy :wk "append line -> lispy state")
         "[" (evil-lispy/enter-state-left :wk "enter lispy mode left")
         "]" (fenton/first-paren :wk "enter lispy mode right")
         ;; "]" (evil-lispy/enter-state-right :wk "enter lispy mode right")

         "{" (fenton/goto-beginning-top-level-sexp-lispy :wk "enter lispy mode right")
         "}" (fenton/goto-end-top-level-sexp-lispy :wk "enter lispy mode right"))
       none-shared-lisp))
(defhydra hydra-edebug-comma-spc-c () ""
  ("c" command-log-mode "toggle command log mode" :exit t)
  ("l" clm/open-command-log-buffer "show command log" :exit t))
(defhydra hydra-edebug-comma-spc () ""
  ("1" winum-select-window-1 "move window 1" :exit t)
  ("2" winum-select-window-2 "move window 2" :exit t)
  ("3" winum-select-window-3 "move window 3" :exit t)
  ("4" winum-select-window-4 "move window 4" :exit t)
  ;; ("o" hydra-spc-o/body ">>FOLD<<" :exit t)
  ("SPC" helm-M-x "run command" :exit t)
  ("b" fenton/backtrace-locals "locals" :exit t)
  ("w" hydra-spc-w/body "Window" :exit t)
  ("c" hydra-edebug-comma-spc-c/body ">COMMAND LOG<" :exit t)
  ("q" nil "quit" exit t))
(setq spc
      '("" nil
        "b" (hydra-spc-b/body :wk ">BUFFERS<")
        "c" (:ignore t :wk "Command Log")
        "d" dired
        "e" (hydra-spc-e/body :wk ">EDIT<")
        "f" (hydra-spc-f/body :wk ">FILES<")
        "g" (:ignore t :wk "Magit")
        "m" (hydra-spc-m/body :wk "Macro")
        "n" (neotree-toggle :wk "NeoTree")
        "p" (:ignore t :wk "Projects")
        "s" (hydra-lisp-spc-s/body :wk "Search/Replace")
        "w" (hydra-spc-w/body :wk "Window" :exit t)

        "1" (winum-select-window-1 :wk "move window 1")
        "2" (winum-select-window-2 :wk "move window 2")
        "3" (winum-select-window-3 :wk "move window 3")
        "4" (winum-select-window-4 :wk "move window 4")
        "5" (winum-select-window-5 :wk "move window 5")
        ;; "/" (helm-projectile-ag :wich-key "ag")
        "/" (helm-do-ag-project-root :wich-key "ag")
        "SPC" (helm-M-x :wk "run command")

        "cc" (command-log-mode :wk "toggle command log mode")
        "cl" (clm/open-command-log-buffer :wk "show command log")

        "gs" (magit-status :wk "magit status")
        "gg" (ft/resolve-un-committed-pushed-code :wk "commit & push") 
        "ga" (ft/auto-commit-n-push :wk "auto commit & push all")
        "gl" (magit-log-buffer-file :wk "log file revisions")
        "gd" magit-diff-buffer-file
        "gb" (:ignore t :wk "Magit Blame")
        "gbb" (magit-blame :wk "magit blame")
        "gbq" (magit-blame-quit :wk "magit blame quit")

        "pp" (counsel-projectile-switch-project :wk "switch to project")
        "pf" (counsel-projectile-find-file :wk "find file")
        "ps" (helm-projectile-ag :wk "find git project file")
        "pr" (projectile-replace :wk "project replace")))

(setq spc-org
      (append spc
              '("o" (hydra-org-spc-o/body :wk "Cycle Visibility" :exit t))))
(setq spc-all
      (append spc
              '("o" (:ignore t :wk "Fold")
                "os" (hs-show-all :wk "show all")
                "oa" (ft/show-buffers :wk "all buffs: show")
                "oh" (hs-hide-all :wk "hide all")
                "oo" (hs-toggle-hiding :wk "toggle folding"))))
(setq comma-cloj-common
      '("." (cider-find-var :wk "find var")
        "," (cider-pop-back :wk "popback from var")
        "c" (hydra-cljr-help-menu/body :wk "CLOJURE REFACTOR")
        "e" (hydra-cider-eval/body :wk "CIDER EVAL")
        "r" (:ignore t :wk "REPL**")
        "t" (hydra-cider-test/body :wk "TEST")
        "rq" (cider-quit :wk "REPL quit")
        "rs" (cider-jack-in-cljs :wk "Make cljscript REPL")))
(setq comma-cloj
      (append
       '("jr" (cider-switch-to-repl-buffer :wk "goto REPL"))
       comma-cloj-common))
(setq comma-cloj-repl
      (append
       '("jr" (:wk "goto REPL")
         "jr" (cider-switch-to-last-clojure-buffer :wk "goto REPL"))
       comma-cloj-common))

(fset 'gdk 'general-define-key)
(apply 'gdk :states 
       '(normal visual emacs)
       none-any-all)
(apply 'gdk :keymaps '(emacs-lisp-mode-map)
       (append '("" nil
                 "e" e-lisp)
               none-any-lisp))
(apply 'gdk :keymaps '(clojure-mode-map)
       (append '("" nil
                 "e" (e-clojure :wk "cider eval")
                 ;; "E" (E-clojure :wk "cider eval")
                 )
               none-any-lisp))
(apply 'gdk :keymaps '(clojure-mode-map)
       :states '(normal visual emacs)
       (append '("" nil
                 "g" (hydra-cloj-g/body :wk "")
                 "K" (kill-line :wk "kill to end of line")
                 "C-i" (ctrl-i :wk "ctrl i")
                 "," (hydra-cloj-comma/body :wk "comma"))
               none-normal-lisp))
(apply 'gdk :keymaps '(markdown-mode-map)
       :states '(normal visual emacs)
       (append '("" nil)
               '("g" (hydra-g/body :wk ""))
               '("," (hydra-markdown-comma/body :wk "comma")))) 
(apply 'gdk :keymaps '(emacs-lisp-mode-map)
       :states '(normal visual emacs)
       (append '("" nil)
               '("g" (hydra-g/body :wk ""))
               '("," (hydra-elisp-comma/body :wk "comma"))
               none-normal-lisp))
(apply 'gdk :keymaps '(org-mode-map)
       :states '(normal visual emacs)
       '("" nil
         "g" hydra-g/body
         "," (hydra-org-comma/body :wk "abc")
         ))
(apply 'gdk :keymaps '(cider-test-report-mode-map)
       :states '(normal visual emacs)
       (append
        '("," (hydra-cider-test-report-comma/body :wk "tests"))
        none-normal-lisp
        '("q" nil
          "q" (cider-popup-buffer-quit-function :wk "quit"))))
(apply 'gdk :keymaps '(cider-repl-mode-map)
       :states '(normal visual emacs)
       (append
        none-normal-lisp
        '("" nil
          "," hydra-repl-comma/body
          "g" hydra-repl-g/body
          "K" cider-repl-backward-input
          "J" cider-repl-forward-input
          "RET" lispy-newline-and-indent-plain
          "i" evil-lispy-state)))
(apply 'gdk :keymaps '(cider-repl-mode-map)
       :states '(input)
       '("C-k" cider-repl-backward-input
         "C-j" cider-repl-forward-input
         "C-d" cider-doc
         "RET" lispy-newline-and-indent-plain))
(apply 'gdk :keymaps '(edebug-mode-map)
       :states '(normal visual emacs)
       '("" nil
        "g" (:ignore t :wk "Magit")
        "," hydra-edebug-comma-spc/body))
(apply 'gdk :keymaps '(help-mode-map)
       :states '(normal input visual emacs)
       '("ESC" cider-popup-buffer-quit-function))
(apply 'gdk :prefix "SPC" :keymaps '(org-mode-map)
       :states '(normal visual emacs motion)
       spc-org)
(apply 'gdk :prefix "SPC" ; keymaps: All
       :states '(normal visual emacs motion)
       spc-all)
(apply 'gdk :keymaps '(sr-mode-map)
       :states '(normal input visual emacs)
       '("q" keyboard-escape-quit
         "j" next-line
         "c" sr-do-copy
         "C-l" sr-do-rename
         "C-k" sr-dired-prev-subdir
         "C-j" sr-advertised-find-file
         "ESC" keyboard-quit
         "h" sr-change-window
         "l" sr-change-window
         "g" revert-buffer
         "k" (lambda () (interactive) (next-line -1))
         "SPC" hydra-sunrise-spc/body))
(apply 'gdk :keymaps '(Info-mode-map)
       :states '(normal input visual emacs)
       '("q" keyboard-escape-quit
         "g" hydra-g/body
         "SPC" hydra-sunrise-spc/body))
(setq dired
      '("" nil
        "j" dired-next-line
        "k" dired-previous-line
        "SPC" dired-mark
        "u" dired-unmark
        "m" dired-do-rename
        "g" (:ignore t :wk "Go")
        "gf" dired-find-file
        "x" dired-do-flagged-delete))
(apply 'gdk :keymaps '(dired-mode-map)
       :states '(normal visual emacs)
       dired) 
(apply 'gdk :keymaps '(magit-revision-mode-map ielm-map help-mode-map magit-log-mode-map)
       :states '(normal visual emacs)
       '("" nil
         "SPC" hydra-spc/body
         "g" hydra-g/body))
(apply 'gdk :keymaps '(magit-diff-mode-map)
       :states '(normal visual emacs)
       '("" nil
         "SPC" hydra-spc/body
         "g" hydra-g/body
         "j" diff-hunk-next
         "k" diff-hunk-prev))
(apply 'gdk :keymaps '(magit-status-mode-map)
       :states '(normal visual emacs)
       '("" nil
         "SPC" hydra-spc/body
         ))
(apply 'gdk :keymaps '(calc-mode-map)
       :states '(normal visual emacs)
       '("" nil
         "ESC" other-window
         ))
(apply 'gdk :keymaps '(elpy-mode-map)
       :states '(normal visual emacs)
       '("" nil
         "e" elpy-shell-send-top-statement
         "E" elpy-shell-send-region-or-buffer
         "g" (hydra-elpy-g/body :wk "")
         "," hydra-comma-elpy/body))
(apply 'gdk :keymaps '(inferior-python-mode-map)
       :states '(normal visual emacs)
       '("" nil
         "g" (:ignore t :wk "Go")
         "gr" elpy-shell-switch-to-buffer
         ))

(general-def org-mode-map "C-'" 'org-edit-special)
(general-def org-src-mode-map "C-'" 'org-edit-src-abort)
;; =======================================================
(eval-after-load "lispy"
       `(progn
          (my-remove-lispy-key (kbd "C-,"))
          (my-remove-lispy-key (kbd "C-j"))
          (my-remove-lispy-key (kbd "d"))
          (my-remove-lispy-key (kbd "e"))
          ;; (my-remove-lispy-key (kbd "E"))
          (my-remove-lispy-key (kbd "g"))
          (my-remove-lispy-key (kbd "o"))
          (my-remove-lispy-key (kbd "O"))
          (my-remove-lispy-key (kbd "s"))
          (my-remove-lispy-key (kbd "w"))
          (my-remove-lispy-key (kbd "A"))
          (my-remove-lispy-key (kbd "a"))
          (my-remove-lispy-key (kbd "l"))
          (my-remove-lispy-key (kbd "f"))
          (my-remove-lispy-key (kbd "F"))
          (my-remove-lispy-key (kbd "h"))
          (my-remove-lispy-key (kbd "K"))
          (my-remove-lispy-key (kbd ","))
          
          ;; (my-remove-lispy-key (kbd "{"))
          ;; (my-remove-lispy-key (kbd "}"))
          ;; (lispy-define-key lispy-mode-map (kbd "{") 'fenton/goto-beginning-top-level-sexp-lispy)
          ;; (lispy-define-key lispy-mode-map (kbd "}") 'fenton/goto-end-top-level-sexp-lispy)
          (lispy-define-key lispy-mode-map (kbd ",") 'hydra-cloj-comma/body)
          (lispy-define-key lispy-mode-map (kbd "K") 'goto-top-level-sexp)
          (lispy-define-key lispy-mode-map (kbd "F") 'lispy-tab)
          ;; (lispy-define-key lispy-mode-map (kbd "g") 'lispy-flow)
          ;; (lispy-define-key lispy-mode-map (kbd "h") 'lispy-flow)
          (lispy-define-key lispy-mode-map (kbd "l") 'lispy-flow)
          (lispy-define-key lispy-mode-map (kbd "o") 'o-lispy)
          (lispy-define-key lispy-mode-map (kbd "O") 'O-lispy)
          (lispy-define-key lispy-mode-map (kbd "d") 'fenton/lispy/delete-n-go-next-sexp)
          (lispy-define-key lispy-mode-map (kbd "x") 'collapse-expand)
          (lispy-define-key lispy-mode-map (kbd "y") 'special-lispy-new-copy)
          (lispy-define-key lispy-mode-map (kbd "p") 'special-lispy-paste)
          (lispy-define-key lispy-mode-map (kbd "P") 'evil-paste-before)
          (lispy-define-key lispy-mode-map (kbd "f") 'lispy-tab)
          ;; (lispy-define-key lispy-mode-map (kbd "i") 'lispy-tab)
          ;; (lispy-define-key lispy-mode-map (kbd "i") 'special-lispy-tab)
          (lispy-define-key lispy-mode-map (kbd "J") 'evil-join)
          (lispy-define-key lispy-mode-map (kbd ":") 'evil-ex)
          ;; (lispy-define-key lispy-mode-map (kbd "\"") 'evil-ex)
          ;; (lispy-define-key lispy-mode-map (kbd "\"") 'lispy-quotes)
          (lispy-define-key lispy-mode-map (kbd "s") 'fenton/hs/lispy/move-sexp-down)
          (lispy-define-key lispy-mode-map (kbd "w") 'fenton/hs/lispy/move-sexp-up)
          (lispy-define-key lispy-mode-map (kbd "i") 'i-lispy-special)
          (lispy-define-key lispy-mode-map (kbd "A") 'A-lispy)
          (lispy-define-key lispy-mode-map (kbd "a") 'a-lispy-special)))  
