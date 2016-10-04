(load "ch4-analyze-comkid.scm")
(load "../misc/scheme-test-r5rs.scm")

(define env (setup-environment))

(define letexp '(let ((a 10) (b 20)) (+ a b)))

;test
(run-named-test
 "ex4.22 -test"
 (make-testcase
      '(assert-equal? 30 (myeval2 letexp env))))