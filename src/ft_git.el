;;; package --- Summary
;; Package-Requires: ((dash "2.16.0"))
;;; Commentary:
(require 'seq)
(require 'magit-git)
(require 'subr-x)

;;; Code:
(defun ft/fetch (buf)
  (with-current-buffer buf
    (magit-git-string-ng "fetch")
    buf))

(defun ft/push (buf)
  (with-current-buffer buf
    (->> buf
         ft/get-curr-branch
         (magit-git-string-ng "push" "origin"))
    buf))

(defun ft/pull (buf)
  (with-current-buffer buf
    (->> buf
         ft/get-curr-branch
         (magit-git-string-ng "pull" "origin"))
    buf))

(defun ft/unique-repos-hashtable (code-bufs)
"Given a list of code buffers, determine how many unique git
  projects exist.  Sometimes we have multiple files open that
  belong to the same git repo, so we only need to operate on the
  repo once. Return hash table of: Key: REPO, Val: BUF"
  (let ((unique-git-repo-bufs #s(hash-table size 30 test equal)))
    (mapc (lambda (code-buf)
            (puthash (magit-toplevel (buffer-file-name code-buf)) code-buf unique-git-repo-bufs))
          code-bufs)
    unique-git-repo-bufs))

;; the list of repos open

;; (-> (ft/code-bufs)
;;     ft/unique-repos-hashtable
;;     hash-table-keys)

(defun ft/minimum-required-code-bufs (code-bufs)
  "Just keep buffer names from unique repo hashtable." 
  (-> code-bufs
      ft/unique-repos-hashtable
      hash-table-values))

(defun ft/diff-count (buf)
  "get diff count of BUF"
  (with-current-buffer buf
    (magit-rev-diff-count "HEAD" (magit-get-upstream-branch))))

(defun ft/behind-ahead-synced (buf)
  "Given the BUF, find out if we are ahead, behind or in sync
with upstream branch."
  (with-current-buffer buf
    (let* ((diff-count (ft/diff-count buf))
           (local (car diff-count))
           (remote (cadr diff-count)))
      (cond ((and (= local 0) (= remote 0)) "synced")
            ((and (> local 0) (> remote 0)) "diverged")
            ((and (> local 0) (= remote 0)) "need to push")
            ((and (= local 0) (> remote 0)) "need to pull")))))

(defun ft/uncommited-code-p (buf)
  "determine if buffer git repo has uncommitted code in it."
  (if (magit-toplevel (buffer-file-name buf)) ;; file belongs to a git repo
      (with-current-buffer buf
        (let ((unpushed-code-p (< 0 (car (magit-rev-diff-count "HEAD" (magit-get-upstream-branch)))))
              (uncommitted-changes-p (magit-git-string-ng "status" "--porcelain")))
          (if (or uncommitted-changes-p unpushed-code-p)
              t
            nil)))))

(defun ft/code-bufs ()
  "go through open buffers.  find candidates that seem like code
buffers."
(->> (buffer-list)
       (seq-filter
        (lambda (x)
          (let* ((buf-name (buffer-name x))
                 (trimmed (string-trim buf-name)))
            (not (or
                  (string-match-p "^\*" trimmed)
                  (string-match-p "^magit" trimmed)
                  (string-match-p ".gz$" trimmed))))))))

(defun ft/get-unique-git-repos ()
  "get code buffers. return subset that represent unique git
repos."
  (ft/minimum-required-code-bufs (ft/code-bufs)))

(defun ft/uncommitted-bufs (bufs)
  "check if there is uncommitted code for the repos. return that
list."
  (seq-filter (lambda (x) (ft/uncommited-code-p x))
              bufs))

;; (ft/uncommitted-bufs)

(defun ft/resolve-un-committed-pushed-code ()
  "open magit status buffer for any repos with uncommited code."
  (interactive)
  (mapc (lambda (buf)
          (with-current-buffer buf
            (magit-status)))
        (ft/uncommitted-bufs (ft/get-unique-git-repos))))

(defun ft/fetch-repos (bufs)
  "give a list of BUFS, fetch each one."
  (mapc (lambda (buf)
          (with-current-buffer buf
            (magit-git-string-ng "fetch")))
        bufs))

(defun ft/get-curr-branch (buf)
  (magit-git-string-ng "rev-parse" "--abbrev-ref" "HEAD"))

(defun ft/process-repo (buf)
  "If uncommited, commit.  Pull & Push."
  (with-current-buffer buf
    (when (ft/uncommited-code-p buf)
      (magit-git-string-ng "commit" "-am" "'.'"))
    (-> buf ft/pull ft/push)
    ;; (let ((status (ft/behind-ahead-synced buf)))
    ;;   (when (string= "diverged" status) (-> buf ft/pull ft/push))
    ;;   (when (string= "need to pull" status) (-> buf ft/pull))
    ;;   (when (string= "need to push" status) (-> buf ft/push)))
    ))

;; (-> (get-buffer "events.cljc")
;;     ft/fetch
;;     ft/diff-count)

;; (-> (get-buffer "events.cljc")
;;     ft/process-repo)

(defun ft/auto-commit-n-push ()
  "This function automatically goes through your code buffers and
automatically commits any unsaved files and pushes to origin on
the current branch."
  (interactive)
  (save-some-buffers t)
  (-map 'ft/process-repo (ft/get-unique-git-repos)))

;; (defun ft/auto-commit-n-push ()
;;   "This function automatically goes through your code buffers and
;; automatically commits any unsaved files and pushes to origin on
;; the current branch."
;;   (interactive)
;;   (save-some-buffers t)
;;   (mapc
;;    (lambda (buf)
;;      (with-current-buffer buf
;;        (magit-git-string-ng "commit" "-am" "'.'")
;;        (let ((curr-branch (magit-git-string-ng "rev-parse" "--abbrev-ref" "HEAD")))
;;          (magit-git-string-ng "pull" "origin" curr-branch)
;;          (magit-git-string-ng "push" "origin" curr-branch))))
;;    (ft/uncommitted-bufs (ft/get-unique-git-repos))))

(defun ft/check-uncommited-then-quit ()
  "autocommit and push code then exit"
  (interactive)
  (ft/auto-commit-n-push)
  (save-buffers-kill-terminal))


