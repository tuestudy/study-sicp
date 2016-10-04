(load "ch4-myeval-pkg-comkid.scm")
(load "../misc/scheme-test-r5rs.scm")

(define the-global-environment (setup-environment))

(define letexp '(let ((a 10) (b 20)) (+ a b)))
(define answer '((lambda (a b) (+ a b)) 10 20))

;test
(display "[ex4.06 - Tests]\n")
(run (make-testcase
      '(assert-equal? answer (let->combination letexp))
      '(assert-equal? 30 (myeval letexp the-global-environment))))