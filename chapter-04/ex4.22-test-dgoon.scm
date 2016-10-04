(load "ex4.22-dgoon.scm")
(load "../misc/scheme-test-r5rs.scm")

;; Reuse test in ex4.06
(define test-environment (setup-environment))
(define test-let '(let ((a 1)
			(b 2))
		    (+ 0 a)
		    (+ a b)))
(define test-lambda '((lambda (a b) (+ 0 a) (+ a b)) 1 2))

(run-named-test "TEST: analyze-let"
		(make-testcase
		 '(assert-equal? 3
				 (myeval test-let test-environment))
		 ))
