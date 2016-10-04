(load "../misc/scheme-test.scm")

(define test 
  (make-testcase
	; tests for a
   '(assert-equal? 4 (deriv '(x + (3 * (x + (y + 2)))) 'x))
   '(assert-equal? 3 (deriv '(x + (3 * (x + (y + 2)))) 'y))
   '(assert-equal? 0 (deriv '(x + (3 * (x + (y + 2)))) 'z))
   ))
