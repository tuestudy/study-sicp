(load "ch4-myeval-for-lazy-comkid.scm")
(load "ch4-force-it-with-memoization.scm")
(load "../misc/scheme-test-r5rs.scm")

(define env (setup-environment))

(myeval '(define (apply-fun f x) (f x)) env) 

(run (make-testcase
      '(assert-equal? 4 (myeval '(apply-fun (lambda (x) (+ x 1)) 3) env))
      ))