(require 'ft/utilities)

(ert-deftest remove-asterix-prefixed-strings-test ()
  (let* ((str-lst '("abc" "*def" "ghi"))
         (without-asterix '("abc" "ghi")))
    (should (equal without-asterix
               (ft/remove-asterix-prefixed-strings str-lst)))))
