(load "ch4-lazy-myeval-pkg-dgoon.scm")
(load "../misc/scheme-test-r5rs.scm")

(define try-definition
  '(define (try a b)
     (if (= a 0) 1 b)))

(define test-environment (setup-environment))

(myeval try-definition test-environment)

(run (make-testcase
      '(assert-equal? 1 (myeval
			 '(try 0 (/ 1 0))
			 test-environment))
      ))