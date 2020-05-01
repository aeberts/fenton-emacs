(load "jump_unit.el")
(require 'jump_unit)
;; ============= Custom Functions ===================
;; (defun in-l()
;;   (interactive)
;;   (if (evil-lispy-state-p)
;;       (message "in lispy state")
;;     (message "NOT in lispy state")))
(defun fenton/rotate-window-split ()
  "if windows split vertically change to horizontally, and vice versa."
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(defun my-join-line ()
  (interactive)
  (delete-indentation)
  (if (evil-lispy-state-p)
      (first-open-paren)))
(defun in-lispy ()
  (interactive)
  (if (evil-lispy-state-p)
      (hydra-buffer-menu/body)
    (self-insert-command)))
(defun collapse-expand ()
  (interactive)
  (hs-toggle-hiding)
  (backward-char))
(defun my-remove-lispy-key (key)
  (define-key lispy-mode-map-base key nil)
  (define-key lispy-mode-map-lispy key nil)
  (define-key lispy-mode-map-oleh key nil)
  (define-key lispy-mode-map-paredit key nil)
  (define-key lispy-mode-map-special key nil))
(defun split-window-vertical-balance ()
  (interactive)
  (split-window-right)
  (balance-windows))
(defun delete-window-balance ()
  (interactive)
  (delete-window)
  (balance-windows))
(defun split-window-below-balance ()
  (interactive)
  (split-window-below)
  (balance-windows))
(defun swap-windows ()
  "swap two windows.  If more or less than two windows are visible, error."
  (interactive)
  (unless (= 2 (count-windows))
    (error "There are not 2 windows."))
  (let* ((windows (window-list))
         (w1 (car windows))
         (w2 (nth 1 windows))
         (w1b (window-buffer w1))
         (w2b (window-buffer w2)))
    (set-window-buffer w1 w2b)
    (set-window-buffer w2 w1b)))
;; (defun lispy-append ()
;;   (interactive)
;;   (forward-char)
;;   (evil-lispy-state))
(defun lispy-parens-from-normal ()
  (interactive)
  (evil-lispy-state)
  (lispy-parens)
  (call-interactively #'evil-lispy/enter-state-left))
(defun load-ns-goto-repl ()
  "Since cider-load-buffer is already an interactive function
must call with: call-interactively in order to not exit after
function call."
  (interactive)
  (call-interactively #'cider-load-buffer)
  (call-interactively #'cider-repl-set-ns)
  (call-interactively #'cider-switch-to-repl-buffer))
(defun o-lispy () 
  (interactive)
  (evil-open-below 1)
  (call-interactively #'evil-lispy-state)) 
(defun O-lispy ()
  (interactive)
  (evil-open-above 1)
  (call-interactively #'evil-lispy-state))
(defun a-lispy ()
  (interactive)
  (evil-append 1)
  (call-interactively #'evil-lispy-state))
(defun a-lispy-special ()
  (interactive)
  (evil-append 1)
  (if (lispy-right-p)
      (progn (insert " ")
             (backward-char)))
  (call-interactively #'evil-lispy-state))
(defun A-lispy ()
  (interactive)
  (if (not (evil-lispy-state-p))
      (evil-append-line 1)
    (evil-lispy-state)
    (lispy-forward 1)
    (evil-append-line 1)
    (evil-lispy-state)
    (backward-char)
    (lispy-newline-and-indent-plain)
    (lispy-newline-and-indent-plain)
    (forward-line -1)
    (lispy-indent-adjust-parens 1))
  (evil-lispy-state)
  
  )
(defun i-lispy-normal ()
  (interactive)
  (cond
   ((lispy-left-p) (progn
                     (insert " ")
                     (backward-char)
                     (evil-lispy-state)))

   ((lispy-right-p) (progn
                      (insert "  ")
                      (backward-char)
                      (evil-lispy-state)))
   (t (progn (evil-lispy-state)))))
(defun i-lispy-special ()
  (interactive)
  (cond ((region-active-p) (lispy-mark-car))

        ((lispy-right-p) (progn
                           (backward-char)
                           (if (lispy-right-p)
                               (insert " "))
                           ;; (backward-char)
                           ))

        ((lispy-left-p) (progn (insert " ")
                               (backward-char)))))
(defun ctrl-i ()
  (interactive)
  (let* ((char-at-point (char-after))
         (char-b4-point (char-before))
         (close-paren 41)
         (open-paren 40))
    (if (region-active-p)
        (lispy-tab)
      (progn
        (if (and char-at-point (= char-at-point open-paren))
            ;; at an opening paren
            (if (in-special-p)
                (special-lispy-tab)))
        (if (and char-b4-point
                 ;; checks that not a beginning of file
                 (= char-b4-point close-paren))
            (progn
              (backward-char)
              (insert " ")
              (backward-char)
              (insert " ")))))
    (if (not (in-special-p))
        (evil-lispy-state))))
(defun I-lispy ()
  (interactive)
  ;; special-lispy-shifttab
  (evil-lispy-state)
  (beginning-of-line 1)
  (fenton/first-paren))
(defun g-in-lispy ()
  (interactive)
  (if (evil-lispy-state-p)
      (hydra-lispy-g/body)
    (self-insert-command)))
(defun ielm-auto-complete ()
  "Enables `auto-complete' support in \\[ielm]."
  (setq ac-sources '(ac-source-functions
                     ac-source-variables
                     ac-source-features
                     ac-source-symbols
                     ac-source-words-in-same-mode-buffers))
  (add-to-list 'ac-modes 'inferior-emacs-lisp-mode)
  (auto-complete-mode 1))
(defun eval-last-sexp-pretty-print ()
  (interactive)
  (cider-eval-print-last-sexp t))
(defun quote-prev-sexp ()
  (interactive)
  (evil-lispy/enter-state-left)
  (lispy-comment)
  (evil-normal-state)
  (insert-space-around-sexp)
  (O-lispy)
  )
(defun lispy-right-p ()
  "Return t if after lispy-right character."
  (looking-back "[])}]"
                (line-beginning-position)))
(defun lispy-left-p ()
  "Return t if on lispy-left character."
  (looking-at "[([{]"))
(defun in-special-p ()
  (and (evil-lispy-state-p)
       (or (lispy-right-p) (lispy-left-p))))
(defun e-clojure ()
  "call cider-eval-last-sexp when in special position"
  (interactive)
  (if (in-special-p)
      (cider-eval-last-sexp)
    (self-insert-command 1)))
;; (defun E-clojure ()
;;   "call cider-eval-last-sexp when in special position"
;;   (interactive)
;;   (if (in-special-p)
;;       (progn (cider-eval-last-sexp)
;;              (ft/reload-reagent))
;;     (self-insert-command 1)))
(defun e-lisp ()
  "call eval-last-sexp if in special position"
  (interactive)
  (if (in-special-p)
      (call-interactively #'eval-last-sexp)
    (self-insert-command 1)))
(defun query-replace-symbol-at-point (inp)
  "jumps to top of file to start the replacing...eeek, dont like
that."
  (interactive
   (let ((symb-at-pt (thing-at-point 'symbol)))
     (list (read-string (format "Replace %s with: " symb-at-pt) nil 'my-history))))
  (let ((symb-at-pt (thing-at-point 'symbol)))
    (query-replace symb-at-pt inp t (line-beginning-position) (point-max))))
(defun at-beginning-of-line-p ()
  (interactive)
  (= (point) (line-beginning-position)))
(defun eval-sexp-or-buffer ()
  (interactive)
  (if (at-beginning-of-line-p)
      (eval-buffer)

    (call-interactively #'eval-defun)))
(defun current-line-empty-p ()
  (save-excursion
    (beginning-of-line)
    (looking-at "[[:space:]]*$")))
(defun char-after-i () (interactive)
       (message "char after is: %s" (char-after)))
(defun top-level-sexp-p () (interactive)
       (and (= 40 (char-after))
            (= 0 (current-column)))) 
(defun goto-top-level-sexp ()
  "go to the beginning of the current defun"
  (interactive)
  (if (not (top-level-sexp-p))
      (beginning-of-defun)))
(defun fenton/goto-beginning-top-level-sexp-lispy ()
  (interactive)
  (goto-top-level-sexp)
  (i-lispy))
(defun fenton/goto-end-top-level-sexp-lispy ()
  (interactive)
  (end-of-defun)
  (backward-char)
  (backward-char)
  (evil-lispy/enter-state-right)) 
(defun forward-parent-sexp ()
  (interactive)
  (goto-top-level-sexp)
  (call-interactively #'lispy-down))
(defun backward-parent-sexp ()
  (interactive)
  (goto-top-level-sexp)
  (call-interactively #'lispy-up))
(defun insert-space-around-sexp ()
  (interactive)
  (save-excursion
    (goto-top-level-sexp)
    (forward-line -1)
    (if (not (current-line-empty-p))
        (progn
          (forward-line 1)
          (open-line 1))
      (forward-line 1)))
  (save-excursion
    (end-of-defun)
    (if (not (current-line-empty-p))
        (progn
          (open-line 1)))))
;; (defun space-around-sexp-p ()
;;   (interactive)
;;   (call-interactively #'point-))
(call-interactively #'end-of-buffer)
(defun space-between-sexps ()
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (forward-sexp)
    ))(defun forward-search-syombol-at-point ()
  "search forward the symbol at point (under the cursor)"
  (interactive)
  (let ((symb-at-pt (thing-at-point 'symbol)))
    (search-forward symb-at-pt)))
(defun end-of-parent-sexp ()
  (interactive)
  (evil-lispy/enter-state-left)
  (special-lispy-beginning-of-defun)
  (o-lispy))
(defun fenton/smart-right-paren ()
  (interactive)
  "If not in lispy mode go to first open or close paren to the
  right.  If in lispy mode, normal navigation."
  (if (not (evil-lispy-state-p))
      (first-open-paren)
    (evil-lispy/enter-state-right)))
(defun fenton/open-par-brk-crly-q ()
  "true if on opening paren, brack or curly"
  (let* ((open-paren 40)
         (open-bracket 91)
         (open-curly 123)
         (char-at-point (char-after)))
    (cond ((eq char-at-point open-paren) t)
          ((eq char-at-point open-curly) t)
          ((eq char-at-point open-bracket) t)
          (t nil))))
(defun fenton/close-par-brk-crly-q ()
  "true if on opening paren, brack or curly"
  (let* ((close-paren 41)
         (close-bracket 93)
         (close-curly 125)
         (char-at-point (char-after)))
    (cond ((eq char-at-point close-paren) t)
          ((eq char-at-point close-curly) t)
          ((eq char-at-point close-bracket) t)
          (t nil))))
(defun fenton/first-paren ()
  (interactive)
  (if (fenton/open-par-brk-crly-q)
      (call-interactively #'evil-lispy/enter-state-right)
    (progn (re-search-forward "[]\(\[{}\)]")
           (backward-char)
           (if (fenton/open-par-brk-crly-q)
               (call-interactively #'evil-lispy/enter-state-left))
           (if (fenton/close-par-brk-crly-q)
               (call-interactively #'evil-lispy/enter-state-right)))))
(defun repl-reload-ns ()
  "Thin wrapper around `cider-test-run-tests'."
  (interactive)
  (when (cider-connected-p)
    (let ((cider-auto-select-test-report-buffer nil)
          (cider-test-show-report-on-success nil))
      (cider-repl-set-ns
       (cider-current-ns))
      (cider-ns-reload))))
(defun load-buffer-set-ns ()
  (interactive)
  (call-interactively #'cider-load-buffer)
  (call-interactively #'repl-reload-ns))
(defun open-test-buffer-from-repl ()
  (interactive)
  (let* ((last-buffer (other-buffer (current-buffer) 1)))
    (find-file-other-window
     (if (in-test-file-p last-buffer)
         (buffer-file-name last-buffer)
       (get-impl-file last-buffer)))))
(defun get-impl-file (test-buffer)
  (interactive)
  (with-current-buffer test-buffer
    (let*
        ((no-test-ns (replace-regexp-in-string "-test" "" (clojure-find-ns)))
         (no-dash-ns (replace-regexp-in-string "-" "_" no-test-ns))
         (no-dot-ns (replace-regexp-in-string (regexp-quote ".") "/" no-dash-ns))
         (file-extension (file-name-extension (buffer-file-name)))
         (impl-file
          (concat (projectile-project-root) "src/" no-dot-ns "." file-extension)))
      impl-file)))
(defun open-impl-file ()
  "open the corresponding implementation file for this test file."
  (interactive)
  (find-file-other-window (get-impl-file (current-buffer))))
(defun get-curr-function-name ()
  (save-excursion
    (goto-top-level-sexp)
    (forward-word)
    (forward-char)
    (thing-at-point 'symbol)))
(defun remove-test-suffix (test-name)
  (replace-regexp-in-string "-tests" "" test-name))
(defun go-to-test-function ()
  "go to test definition file and goto first test that tests the
function that you are currently in/on.  test functions should be
named <function-under-test-name>-<some number>-test"
  (interactive)
  (let ((curr-fn-name (get-curr-function-name)))
    (open-test-file)
    (goto-char (point-min))
    (search-forward (concat "deftest " curr-fn-name))))
(defun go-to-impl-function ()
  "when you are in a test function that is named appropriately,
find the corresponding function that this test is testing.  test
functions should be named <function-under-test-name>-<some
number>-test"
  (interactive)
  (debug)
  (let* ((curr-fn-name (get-curr-function-name))
         (curr-fn-name-no-suffix (remove-test-suffix curr-fn-name)))
    (open-impl-file)
    (goto-char (point-min))
    (search-forward (concat "defn " curr-fn-name-no-suffix))))
(defun in-test-file-p (&optional buffer)
  "true/false predicate if in a test file."
  (let ((pref (concat (projectile-project-root) "test/"))
        (buf (if buffer
                 (buffer-file-name buffer)
               (buffer-file-name))))
    (string-prefix-p pref buf)))
(defun get-test-or-impl-file (ns fn pr)
  (let* ((extn (file-name-extension fn))
         (ns-path (convert-dot-dash-namespace ns))
         (relative-root (get-relative-root pr ns-path fn extn))
         )))
(defun set-plist! (plist key value)
  (setq plist (plist-put plist key value)))
(defun project-relative-path ()
  (interactive)
  (let* ((plst '())
         (buf-name (buffer-name))
         (projectile-file-p (string-prefix-p pr buf))
         (file-name (buffer-file-name))
         (projectile-root (projectile-project-root))
         )
    (set-plist plst 'projectile-root projectile-root)
    (set-plist plst 'file-name file-name)
    (set-plist plst 'projectile-file-p projectile-file-p)
    (set-plist plst 'buffer-name buf-name)
    (set-plist plst 'in-repl-p (string-prefix-p "*cider-repl " buf-name))
    ;; (set-plist plst)
;; http://ergoemacs.org/emacs/elisp_property_list.html  
    
    
    (if proj-file-p
        (substring buf (length pr))
      nil)
    plst))
(defun in-repl-p ()
  (let* ((buf-name (buffer-name)))
    (string-prefix-p "*cider-repl " buf-name)))
(defun in-file-of-type ()
  (interactive)
  (cond
   ((in-repl-p) 'repl)
   ((in-test-file-p) 'test-file)
   (t 'source-file)))
(defun ifot ()
  (interactive)
  (pcase (in-file-of-type)
    ('repl (message "in repl"))
    ('test-file (message "test file"))
    ('source-file (message "source file"))
    (otherwise (message "Unknown file type %S" otherwise))))
(defun goto-last-clojure-file ()
  (interactive)
  (if (in-test-file-p)
      toggle-goto-test-impl)
  ()
  )
(defun goto-clojure-spec-file ()
  (interactive)
  (let* ((ns
          (if (in-test-file-p)
              toggle-goto-test-impl))))
  (if (in-test-file-p)
      toggle-goto-test-impl))
(defun find-clojure-ns ()
  (interactive)
  (message "cloj ns: %s" (clojure-find-ns)))
;; when a cider file is loaded refresh ns
;; (defun my-reload-dependents ()
;;   (let* ((buf (get-buffer (cider-current-repl-buffer)))
;;          (ns (with-current-buffer buf nrepl-buffer-ns)))
;;     (cider-tooling-eval
;;      (format
;;       "(when-let [rd (resolve 'com.palletops.ns-reload.repl/ns-reload-hook)]
;;          (@rd '%s {))"
;;       (cider-current-ns))
;;      (cider-interactive-eval-handler buf)
;;      ns)))
;; (add-hook 'cider-file-loaded-hook 'my-reload-dependents)
(defun help/save-all-file-buffers ()
  "Saves every buffer associated with a file."
  (interactive)
  (dolist (buf (buffer-list))
    (with-current-buffer buf
      (when (and (buffer-file-name) (buffer-modified-p))
        (save-buffer)))))
(defun rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))
(defun test-this-buffer ()
  (interactive)
  (cider-test-execute (clojure-find-ns)))
(defun delete-this-buffer ()
  (interactive)
  (delete-file (buffer-file-name)))
(defun er-delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))
;; clomacs: clojure<->elisp interactions
(clomacs-defun ft/reload-reagent-clj
               dhl-oms.home-page/mount)

(defun ft/reload-reagent ()
  (interactive)
  (ft/reload-reagent-clj))

(clomacs-defun ft/dump-pm-logs
               dhl-oms.events/pm-dump)

(defun ft/pm-logs ()
  "This calls postmortem to dump the logs into the current buffer."
  (interactive)
  (princ (ft/dump-pm-logs) (current-buffer)))

(defun repl-refresh ()
  (interactive)
  (clomacs-defun start-system ds-queue.startup/start)
  (clomacs-defun stop-system ds-queue.startup/stop)
  (stop-system)
  (cider-ns-refresh)
  (start-system))

(defun fill-p-forward-p ()
  (interactive)
  (lispy-fill)
  (forward-paragraph)
  (forward-line)
  (recenter))

(defun my-dired-find-file (&optional arg)
  "Open each of the marked files, or the file under the point, or when prefix arg, the next N files "
  (interactive "P")
  (let* ((fn-list (dired-get-marked-files nil arg)))
    (mapc 'find-file fn-list)))

(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))

(defun unfill-paragraph-forward-p ()
  (interactive)
  (unfill-paragraph)
  (forward-paragraph)
  (forward-line)
  (recenter))

(defun fenton/end-of-parent-sexp () (interactive)
       (lispy-beginning-of-defun)
       (special-lispy-different))

;; these should be collapsed into one function that takes a direction argument
(defun fenton/next-code-buffer ()
  (interactive)
  (let (( bread-crumb (buffer-name) ))
    (next-buffer)
    (while
        (and
         (or
          ;; this should be a list of regex matches that we compare agains
          (string-match-p "^\*" (buffer-name))
          (string-match-p "^magit" (buffer-name)))
         (not ( equal bread-crumb (buffer-name) )) )
      (next-buffer))))

(defun fenton/previous-code-buffer ()
  (interactive)
  (let (( bread-crumb (buffer-name) ))
    (previous-buffer)
    (while
        (and
         (or
          (string-match-p "^\*" (buffer-name))
          (string-match-p "^magit" (buffer-name)))
         (not ( equal bread-crumb (buffer-name) )) )
      (previous-buffer))))

(defun fenton/lispy/delete-n-go-next-sexp ()
  (interactive)
  (if (in-special-p)
      (progn (call-interactively #'lispy-kill-at-point)
             (lispy-forward 1)
             (lispy-backward 1))
    (lispy-kill-at-point))) 

(defun fenton/hs/lispy/move-sexp-up ()
  (interactive)
  (if (hs-already-hidden-p)
      (progn (lispy-move-up 1)
             (hs-hide-block)
             (backward-char))
    (lispy-move-up 1)))

(defun fenton/hs/lispy/move-sexp-down ()
  (interactive)
  (if (hs-already-hidden-p)
      (progn
        (lispy-move-down 1)
        (hs-hide-block)
        (backward-char))
    (lispy-move-down 1)))

(defun my-flymd-browser-function (url)
  (let ((browse-url-browser-function 'browse-url-firefox))
    (browse-url url)))

(defun fenton/backtrace-locals ()
  (interactive)
  (backtrace--locals 0))

(defun ft/eval-last-sexp-print-in-comment ()
  (interactive)
  (eval-print-last-sexp)
  (backward-sexp 1)
  (lispy-comment)
  (evil-lispy/enter-state-left))

(defun fenton/first-paren ()
  (interactive)
  (if (string= "(" (char-to-string (char-after)))
      (call-interactively #'evil-lispy/enter-state-right)
    (re-search-forward "[]\(\[{}\)]")
    (backward-char)
    (if (fenton/open-par-brk-crly-q)
        (call-interactively #'evil-lispy/enter-state-left))
    (if (fenton/close-par-brk-crly-q)
        (call-interactively #'evil-lispy/enter-state-right))))

(defun ft/elisp-index-symbol-at-point ()
  (interactive)
  (elisp-index-search (thing-at-point 'symbol)))

(defadvice find-file
    (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir t)))))
;; -------
;; i = special-special-lispy-tab
;; f = special-special-lispy-flow
;; h = special-lispy-left
;; l = special-lispy-right
;; a = special-lispy-ace-symbol

;; need a way, when in special-lispy-mode to quickly get before or after the paren to insert regular text
;; want to use i and a for that.
;; -------
;; f = lispy-tab
;; h = 
;; l = lispy-flow
;; i = becomes insert
;; a = append

;; before and after when i is pressed
;; ((   --->    ( ( 
;;  ^            ^
;; ))   --->     )) 
;;  ^            ^
(defun wrap-cider-eval () (interactive)
       (cider-interactive-eval nil message )
       )

(defun ft/fix-bank-statement ()
  (interactive)
  (search-forward-regexp "[[:digit:]]"))
