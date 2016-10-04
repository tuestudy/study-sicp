(load "ex4.07-dgoon.scm")
(load "../misc/scheme-test-r5rs.scm")

(display "----- TEST for EX 4.07 -----\n")
(define test-environment (setup-environment))
(define test-let* '(let* ((x 3)
			 (y (+ x 2))
			 (z (+ x y 5)))
		     (set! x 3)
		     (+ 0 x)
		     (* x z)))
(define test-nested-lets '(let ((x 3))
			    (let ((y (+ x 2)))
			      (let ((z (+ x y 5)))
				(set! x 3)
				(+ 0 x)
				(* x z)))))


(display "test for validity of result-nested-lets\n")
(run (make-testcase
      '(assert-equal? 39
		      (myeval test-nested-lets
			      test-environment))))
				  
(display "test for make-one-arg-let\n")
(run (make-testcase
      '(assert-equal? '(let ((a 1)) b)
		      (make-one-arg-let 'a
					'1
					'(b)))
      ;'(assert-equal? '(let () b)
      '(assert-equal? 'b
		      (make-one-arg-let '()
					'()
					'(b)))
      '(assert-equal? '(let ((a 1)) 1 2)
		      (make-one-arg-let 'a
					'1
					'(1 2)))
					
      ))

(display "test for let*->nested-lets\n")
(run (make-testcase
      '(assert-equal? test-nested-lets
		      (let*->nested-lets test-let*))
      '(assert-equal? (myeval test-nested-lets
			      test-environment)
		      (myeval test-let*
			      test-environment))
      '(assert-equal? 39
		      (myeval test-let*
			      test-environment))
      ))