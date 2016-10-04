(load "ex4.08-dgoon.scm")

(display "----- TEST for EX 4.08 ----\n")

(define test-environment (setup-environment))
(define testcase-from-book
  '(let fib-iter ((a 1)
		  (b 0)
		  (count 5))
     (if (= count 0)
	 b
	 (fib-iter (+ a b) a (- count 1)))))

(display "test if legacy works\n")
(run (make-testcase
      '(assert-equal? 3
		      (myeval '(let ((x 1) (y 2))
				 (+ x y))
			      test-environment))
      ))

(display "test named-let?\n")
(run (make-testcase
      '(assert-false? (named-let? '(let ((x 1)) x)))
      '(assert-true? (named-let? '(let test ((x 1)) x)))
      '(assert-true? (named-let? testcase-from-book))
      ))

(display "test named-let selectors\n")
(define test-named-let '(let test-func bindings body))
(run (make-testcase
      '(assert-equal? 'test-func
		      (named-let-var test-named-let))
      '(assert-equal? 'bindings
		      (named-let-bindings test-named-let))
      '(assert-equal? 'body
		      (named-let-body test-named-let))
      ))

(display "test expand-named-let\n")
(run (make-testcase
      '(assert-equal? '(begin (define test-func
				(lambda (x) (+ x 1)))
			      (test-func 5))
		      (expand-named-let '(let test-func ((x 5))
					   (+ x 1))))
      ))

(display "test myeval with named-let\n")
(run (make-testcase
      '(assert-equal? 5
		      (myeval testcase-from-book test-environment))
      ))