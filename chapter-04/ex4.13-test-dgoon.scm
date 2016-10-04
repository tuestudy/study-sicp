(load "ex4.13-dgoon.scm")
(load "../misc/scheme-test-r5rs.scm")

(define test-environment (setup-environment))

(define test-code-1
  '(let ((a 1))
     (let ((a 2))
       a)))

(define test-code-2
  '(let ((a 1))
     (let ((a 2))
       (begin
	 (make-unbound! a)
	 a))))

(define test-frame
  (make-frame '(a b c d)
	      '(1 2 3 4)))

(run-named-test "TEST for filter"
		(make-testcase
		 '(assert-equal? '(1 2 3 5)
				 (filter (lambda (x) (not (= x 4)))
					 '(1 2 3 4 5)))
		 '(assert-equal? '(1 2 3 4)
				 (filter (lambda (x) (< x 5))
					 '(1 2 3 4 5)))
		 ))

(run-named-test "TEST for make-new-frame-without"
		(make-testcase
		 '(assert-equal? test-frame
				 (make-new-frame-without 'e test-frame))
		 '(assert-equal? (make-frame '(a b d)
					     '(1 2 4))
				 (make-new-frame-without 'c test-frame))
		 ))

(run-named-test "TEST for lookup local variable"
		(make-testcase
		 '(assert-equal? 2 (myeval test-code-1
					   test-environment))
		 ))

(run-named-test "TEST for lookup outer variable after unbound"
		(make-testcase
		 '(assert-equal? 1 (myeval test-code-2
					   test-environment))))
