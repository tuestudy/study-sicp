(load "ex4.26-dgoon.scm")

(run-named-test "unless->if"
		(make-testcase
		 '(assert-equal? '(if c u e)
				 (unless->if '(unless c e u)))
		 ))

(define factorial-with-unless
  '(define (factorial n)
     (unless (= n 1)
	     (* n (factorial (- n 1)))
	     1)))

(define (fact n)
  (if (= n 1)
      1
      (* n (fact (- n 1)))))

(define test-environment (setup-environment))
(myeval factorial-with-unless test-environment)

(run-named-test "Factorial-with-unless"
		(make-testcase
		 '(assert-equal? (fact 1)
				 (myeval '(factorial 1)
					 test-environment))
		 '(assert-equal? (fact 10)
				 (myeval '(factorial 10)
					 test-environment))
		 ))
