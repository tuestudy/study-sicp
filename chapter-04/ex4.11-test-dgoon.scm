(load "ex4.11-dgoon.scm")
(load "../misc/scheme-test-r5rs.scm")

(define test-environment (setup-environment))

(define test-frame (make-frame '(a b c) '(1 2 3)))
(define test-frame-2 (make-frame-2 '(a b c) '(1 2 3)))

(define test-proc
  '(define (fact n)
     (if (or (= 1 n)
	     (> 1 n))
	 1
	 (* n (fact (- n 1))))))

(run-named-test "TEST for ORIGINAL IMPLEMENTATION"
		(make-testcase
		 '(assert-equal? '((a b c) 1 2 3)
				 test-frame)
		 '(assert-equal? '(a b c)
				 (frame-variables test-frame))
		 '(assert-equal? '(1 2 3)
				 (frame-values test-frame))
))

(myeval test-proc test-environment)
(run-named-test "TEST for Evaluating factorial"
		(make-testcase
		 '(assert-equal? 1
				 (myeval '(fact 1)
					 test-environment))
		 '(assert-equal? 120
				 (myeval '(fact 5)
					 test-environment))
		 ))

(run-named-test "TEST for REWRITTEN IMPLEMENTATION"
		(make-testcase
		 '(assert-equal? '((a . 1) (b . 2) (c . 3))
				 test-frame-2)
		 '(assert-equal? '(a b c)
				 (frame-variables-2 test-frame-2))
		 '(assert-equal? '(1 2 3)
				 (frame-values-2 test-frame-2))
		 ))

(define make-frame make-frame-2)
(define frame-variables frame-variables-2)
(define frame-values frame-values-2)
(define add-binding-to-frame! add-binding-to-frame-2!)
(define new-test-environment (setup-environment))

(myeval test-proc new-test-environment)

(run-named-test "TEST for Evaluating factorial"
		(make-testcase
		 '(assert-equal? 1
				 (myeval '(fact 1)
					 new-test-environment))
		 '(assert-equal? 120
				 (myeval '(fact 5)
					 new-test-environment))
		 ))