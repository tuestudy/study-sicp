(load "ex4.09-dgoon.scm")
(load "../misc/scheme-test-r5rs.scm")

(define test-environment (setup-environment))

(define while
  '(while ((i 0) (sum 0))
	  (lambda () (< i 10))
	  (begin
	    (set! sum (+ sum i))
	    (set! i (+ i 1))
	    sum)))

(define derived-while
  '(let _while ((i 0)
		       (sum 0))
     (let ((body (begin
		   (set! sum (+ sum i))
		   (set! i (+ i 1))
		   sum)))
       (if ((lambda () (< i 10)))
	   (_while i sum)
	   body))))

(run-named-test "TEST for SELECTORS"
		(make-testcase
		 '(assert-true? (while? while))
		 '(assert-equal? '((i 0) (sum 0)) (while-bindings while))
		 '(assert-equal? '(lambda () (< i 10)) (while-predicate while))
		 '(assert-equal? '(begin
				    (set! sum (+ sum i))
				    (set! i (+ i 1))
				    sum)
				 (while-body while))
		 ))

(run-named-test "TEST for derived-while"
		(make-testcase
		 '(assert-equal? 45
				 (myeval derived-while
					 test-environment))))

(run-named-test "TEST for while->named-let"
		(make-testcase
		 '(assert-equal? derived-while
				 (while->named-let while))
		 '(assert-equal? 45
				 (myeval (while->named-let while)
					 test-environment))
		 ))
