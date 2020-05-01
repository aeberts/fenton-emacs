(require 'seq)

(defun ft/code-buffer-names ()
  (seq-filter (lambda (x)
                (and (not (or (string-match-p "^\*" x)
                              (string-match-p "^magit" x)
                              (string-match-p "^ " x)))
                     (or (string-match-p ".el$" x)
                         (string-match-p ".clj$" x)
                         (string-match-p ".cljc$" x)
                         (string-match-p ".cljs$" x))))
              (mapcar 'buffer-name (buffer-list))))

(defun ft/show-buffers ()
  "expand (as opposed to collapse) all buffers"
  (interactive)
  (mapcar (lambda (buf)
            (with-current-buffer
                (set-buffer buf)
              (hs-show-all)))
          (ft/code-buffer-names)))

;; (call-interactively 'my-fn t (vector arg1 arg2))
(magit-toplevel default-directory)

(provide 'ft/utilities)
