;;; package --- Summary
;;; Commentary:
(require 'jump_unit)

;;; Code:

(ert-deftest ft/swap-test-src-fn-test ()
  (let ((just-fn "core.clj")
        (just-fn-2 "jump_unit.el")
        (just-test-fn "core_test.clj")
        (fn "/home/fenton/projects/blah/src/blah/core.clj")
        (test-fn "/home/fenton/projects/blah/test/blah/core_test.clj")
        (test-fn-2 "/home/fenton/projects/blah/test/blah/jump_unit_test.el"))
    (should (string= just-test-fn (ft/swap-test-src-fn fn)))
    (should (string= just-fn (ft/swap-test-src-fn test-fn)))
    (should (string= just-fn-2 (ft/swap-test-src-fn test-fn-2)))))

;; TODO: come back here to fix the situation where you are in a clj
;; test file and you want to go to a cljc impl file.

(ert-deftest ft/maybe-add-c-2-fn-test ()
  (let ((fn "/home/fenton/projects/blah/src/blah/core.cljc")
        (test-fn "/home/fenton/projects/blah/test/blah/core_test.clj"))
    ;; (should (string= fn (ft/maybe-add-c-2-fn test-fn)))
    ;; can't test requires files to exist in filesystem...i.e. side effect dependend.
    ;; (should (string= test-fn (ft/maybe-add-c-2-fn fn)))
    ))

(ert-deftest ft/swap-test-src ()
  (should (string= "test" (ft/swap-test-src "src")))
  (should (string= "src" (ft/swap-test-src "test")))
  (should (string= "blah" (ft/swap-test-src "blah"))))

(ert-deftest ft/is-file-type-p-test ()
  (let ((fn "/home/fenton/projects/blah/src/blah/core.clj"))
    (should (equal t (ft/is-file-type-p fn "src")))))

(ert-deftest ft/get-jump-fn-test ()
  (let ((fn "/home/fenton/projects/blah/src/blah/core.clj")
        (test-fn "/home/fenton/projects/blah/test/blah/core_test.clj"))
    (should (string= test-fn (ft/get-jump-fn fn)))
    (should (string= fn (ft/get-jump-fn test-fn)))))

(ert-deftest ft/maybe-add-c-2-fn-pure ()
  (let ((fn-clj "/home/fenton/projects/blah/src/blah/core.clj")
        (fn-cljc "/home/fenton/projects/blah/src/blah/core.cljc")
        (test-fn "/home/fenton/projects/blah/test/blah/core_test.clj")
        (jump-file-exists t)
        (jump-file-doesnt-exist nil))

    ;; impl cljc -> test clj
    (should (string= test-fn
                     (ft/maybe-add-c-2-fn-pure jump-file-doesnt-exist test-fn)))

    ;; test clj -> impl cljc
    (should (string= fn-cljc (ft/maybe-add-c-2-fn-pure jump-file-doesnt-exist fn-clj)))))

(ert-deftest src-2-test-cljc ()
  (let ((test "/home/fenton/projects/dhl/test/dhl_oms/events_test.clj")
        (target-exists-p nil))
    (should (string= test (ft/maybe-add-c-2-fn-pure
                           target-exists-p
                           test)))))
