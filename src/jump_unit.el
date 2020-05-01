;;; package --- Summary
;;; Commentary:
(require 'seq)

;; This code helps to jump from an implementation src file to it's
;; corresponding test file, works for clojure and elisp.
;;; Code:

(defun ft/is-file-type-p (fn-path type)
  "Check to see if the supplied filename path (FN-PATH) is in the test or
src directory according to the TYPE parameter.

TYPE: src|test
FN-PATH: full path of file"
  (cond
   ((not (null (seq-filter
                (lambda (x) (string= type x))
                (split-string fn-path "\/")))) t)
   (t nil)))

(defun ft/swap-test-src (dirname)
  (cond
   ((string= "src" dirname) "test") 
   ((string= "test" dirname) "src")
   (t dirname)))

(defun ft/swap-test-src-fn (fn)
  "convert a src filename to a test filename, and
vice-versa. Doesn't include full path, just fn."
  (let*
      ((dirs (split-string fn "\/"))
       (split-just-fn (split-string (first (last dirs)) "\\."))
       (extn (first (last split-just-fn)))
       (just-fn (first split-just-fn))
       )
    (if (ft/is-file-type-p fn "src")
        (if (string= "cljc" extn)
            (concat just-fn "_test.clj")
          (concat just-fn "_test." extn))
      (if (ft/is-file-type-p fn "test")
          (concat
           (string-join (butlast (split-string just-fn "_")) "_")
           "." extn)
        fn))))

(defun ft/get-jump-fn (fn)
  "FN = filename, get-jump-filename if in implementation file,
jump to test file and vice-versa.  Converts full-path."
  (let*
      ((split-path (split-string fn "\/"))
       (swapped-dir (mapcar 'ft/swap-test-src split-path))
       (just-fn (last split-path))
       (swapped-fn (ft/swap-test-src-fn fn))
       (but-fn (butlast swapped-dir))
       (new-dir-n-fn (append but-fn (list swapped-fn))))
    ;; TODO convert fn.clj -> fn_test.clj, or fn_test.clj -> fn.clj
    (string-join new-dir-n-fn "/")))

(defun ft/maybe-add-c-2-fn-pure (jump-file-exists-p jump-fn)
  "pure.  if in impl cljc file -> test clj file.  if in clj test
file -> if there isn't a clj impl go to the cljc impl file."
  (let ((jumping-to-src-file (ft/is-file-type-p jump-fn "src")))
    (if jump-file-exists-p
        jump-fn
      (if jumping-to-src-file
          (concat jump-fn "c")
        jump-fn))))

(defun ft/maybe-add-c-2-fn (fn)
  "Not PURE, checks file system for existence of file to
  determine where to jumpt to!

Sometimes we are in a *.clj test file and want to go to a *.cljc
impl file.

Still need to handle case of: *.cljc impl file to *.clj test
  file."
  (let ((jump-fn (ft/get-jump-fn fn)))
    (ft/maybe-add-c-2-fn-pure
     (file-exists-p jump-fn) jump-fn)))

(defun ft/jump-to-src-or-test-file ()
  (interactive)
  (find-file-other-window (ft/maybe-add-c-2-fn (buffer-file-name))))
;; running tests *.cljs on project: DHL !!!!
(clomacs-defun ft/run-cljs-tests
               dhl-oms.test-runner/my-tests)

(defun ft/run-tests ()
  "Run different test commands based on file extension.
*.cljs -> ft/run-cljs-tests
*.clj  -> cider-test-run-ns-tests
"
  (interactive)
  (let ((extn (file-name-extension buffer-file-name)))
    (cond
     ((string= "cljs" extn) (ft/run-cljs-tests))
     ((or (string= "clj" extn) (string= "cljc" extn))
      (cider-test-run-ns-tests nil))
     ((string= "el" extn) (ert t))
     (t (message "Dont know how to run tests for file with extension: %s" extn)))))

;; (defun ft/toggle-goto-test-impl ()
;;   (interactive)
;;   (let* ((ns (clojure-find-ns))
;;          (fn (buffer-file-name))
;;          (pr (projectile-project-root))))
;;   (find-file-other-window (get-test-or-impl-file ns fn pr))
;;   (if (in-test-file-p)
;;       (go-to-impl-function)
;;     (go-to-test-function)))

(provide 'jump_unit)
;;; jump_unit.el ends here
